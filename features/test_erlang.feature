Feature: Testing an Erlang project

  Background:
   Given the following test payload
     | repository | travis-ci/travis-ci                                 |
     | commit     | 1234567                                             |
     | config     | language: erlang, opt_release: R14B04, env: FOO=foo |

  Scenario: A successful build
    When it starts a job
    Then it exports the given environment variables
     And it successfully clones the repository to the build dir with git
     And it successfully checks out the commit with git to the repository directory
     And it successfully switches to the erlang version: R14B04
     And it does not find the file rebar.config or Rebar.config
     And it successfully runs the script: make test
     And it closes the ssh session
     And it returns the status 0
     And it has captured the following events
       | name            | data                                          |
       | job:test:start  | started_at: [now]                             |
       | job:test:log    | log: /Using worker/                           |
       | job:test:log    | log: cd ~/builds                              |
       | job:test:log    | log: export FOO                               |
       | job:test:log    | log: git clone                                |
       | job:test:log    | log: cd travis-ci/travis-ci                   |
       | job:test:log    | log: git checkout                             |
       | job:test:log    | log: source /home/vagrant/otp/R14B04/activate |
       | job:test:log    | log: make test                                |
       | job:test:log    | log: /Done.* 0/                               |
       | job:test:finish | finished_at: [now], status: 0                 |

  Scenario: A successful build with a rebar.config file
    When it starts a job
    Then it exports the given environment variables
     And it successfully clones the repository to the build dir with git
     And it successfully checks out the commit with git to the repository directory
     And it successfully switches to the erlang version: R14B04
     And it finds a file rebar.config and successfully installs the rebar dependencies
     And it successfully runs the script: ./rebar compile && ./rebar skip_deps=true eunit
     And it closes the ssh session
     And it returns the status 0
     And it has captured the following events
       | name            | data                          |
       | job:test:start  | started_at: [now]             |
       | job:test:log    | log: /Using worker/           |
       | job:test:log    | log: cd ~/builds              |
       | job:test:log    | log: export FOO               |
       | job:test:log    | log: git clone                |
       | job:test:log    | log: cd travis-ci/travis-ci   |
       | job:test:log    | log: git checkout             |
       | job:test:log    | log: /activate/               |
       | job:test:log    | log: ./rebar get-deps         |
       | job:test:log    | log: /eunit/                  |
       | job:test:log    | log: /Done.* 0/               |
       | job:test:finish | finished_at: [now], status: 0 |

  Scenario: The repository can not be cloned
    When it starts a job
    Then it exports the given environment variables
     And it fails to clone the repository to the build dir with git
     And it closes the ssh session
     And it returns the status 1

  Scenario: The commit can not be checked out
    When it starts a job
    Then it exports the given environment variables
     And it successfully clones the repository to the build dir with git
     And it fails to check out the commit with git to the repository directory
     And it closes the ssh session
     And it returns the status 1

  Scenario: The erlang version can not be activated
    When it starts a job
    Then it exports the given environment variables
     And it successfully clones the repository to the build dir with git
     And it successfully checks out the commit with git to the repository directory
     And it fails to switch to the erlang version: R14B04
     And it closes the ssh session
     And it returns the status 1

  Scenario: The bundle can not be installed
    When it starts a job
    Then it exports the given environment variables
     And it successfully clones the repository to the build dir with git
     And it successfully checks out the commit with git to the repository directory
     And it successfully switches to the erlang version: R14B04
     And it finds a file rebar.config but fails to install the rebar dependencies
     And it closes the ssh session
     And it returns the status 1

  Scenario: A failing build
    When it starts a job
    Then it exports the given environment variables
     And it successfully clones the repository to the build dir with git
     And it successfully checks out the commit with git to the repository directory
     And it successfully switches to the erlang version: R14B04
     And it does not find the file rebar.config or Rebar.config
     And it fails to run the script: make test
     And it closes the ssh session
     And it returns the status 1
