# oasis

This project is used to manage services in a way of separation-of-concerns.

  - Script utilities to manage the service lifecycle.

### Installation

Install the services.

```sh
$ ./install.sh
```

### Run

Run the services.

```sh
$ ./run.sh
````

### Files Structure

* Scripts in the root directory of the project
    The main entry script is ``oasis.sh``. The environment configuration file is ``env.sh``. The other executables are just shortcuts of the common commands.

* services.ini
    The content of this file is like below:
    ```ini
    example=40001
    ```
    This file configures the name of the service mapped by the port bound to it.

* apps/<service>
    The source code and its build of this service. It contains all the logic of the service.

* controls/<service>
    The control scripts of this service. The corresponding operations may be implemented in each script.    

* data/<service>
    The persistent data of this service. The service should store all persistent data here. This directory will be used for keeping data. Data imported from and exported to should also be saved here.

### Service Operations

Following are the operations of a managed service.

1. Init
    Initialize the service. *Optional*.

2. Import
    Import data from ``data/<service>``. *Optional*.

3. Update
    Pull the latest code and update the ``apps/<service>``. *Optional*.

4. Export
    Export data to ``data/<service>``. *Optional*.

5. Start
    Start ``apps/<service>``. *Required*.

6. Status
    Query the status of ``apps/<service>``. *Required*.

7. Stop
    Stop ``apps/<service>``. *Required*.

### Custom Service

To add a new custom service, follow the steps:

1. Add custom port binding.
    Add the custom port binding in ``services.ini``.

2. Add custom app codebase.
    Create a new directory in ``apps``. Add custom app codebase into this directory.

3. Add custom app control scripts.
    Copy scripts from ``controls/example``. Remove unnecessary scripts. Modify related scripts to provider controlling behavior to your custom service.

4. Test custom service.
    Run scripts to test custom service.
