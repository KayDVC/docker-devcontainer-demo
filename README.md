## Prereqs 
- Clone the repo. 

- You're going to need to download and install [Docker Desktop](https://www.docker.com/products/docker-desktop/) for your OS. This comes with the Docker CLI, Engine, and Docker Compose which we'll be heavily relying on.

- You should also install the [VSCode Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) within VSCode. You can do this by:
    1)  Opening VSCode
    2)  Clicking the extensions icon
    ![This is where the Extensions shortcut is](./Assets/extensions_location.png)
    3) Search Dev Containers. Should look like this.
    ![This is what Dev Containers looks like](./Assets/devcontainers.png)
    4) Install
    5) Restart VSCode after installation.

- You'll need to reopen VScode in the **docker-devcontainer-demo** folder.

## Docker Basics

- Whenever doing anything with docker, make sure its process is running in the background. Either open the app or check your background processes if you're unsure.

- The only command you will generally need to run for this demo is `docker compose build` when building the a new image,`docker compose up` to start the image(s), and `docker compose down` when troubleshooting. 
    - Note:  `docker compose up --build` is the shorthand command to both build and start the image(s).

- To start, open a command terminal the VSCode window and run the command `docker compose build` to build a new image. This will be the crux of the development environment shared across the team.
    - The base image is alpine linux, a very small and portable distribution of linux, with python installed. There are also other applications like git and an SSH client installed for our convenience.
    - At this stage, you should not have any errors. If you do, double check that your Docker Engine and you're running these commands within VScode's terminal.

- **The next sections will utilize port 4001 & 4002.** This is normally not an issue unless you know you have some other process running on these ports.

- Continue by running `docker compose up`. This may take a few moments since the image has to build from scratch for the first time. On subsequent runs, the process will be way shorter. Output should look somewhat like this.

![Docker Output should look like this](./Assets/docker_compose_up_output.png)

- Note the section pointed to. Copy and paste this address in any web browser. It should open up a page created using Flask, a python API module.
    - You can also access this page by going to [localhost:4001](http://localhost:4001)

- Pros: 
    1. One and done approach. Setup once and continue to use.
    2. Combine multiple different images to compose one app. For instance, you can have a image with nodejs (Frontend/Backend) + an image with mongodb (Database) running at the same time to form an entire application.
    3. Portable. Share the dockerfiles and run them. That's it.

- Cons: 
    1. Only helps when it comes to executing the program. Actual coding and troubleshooting don't get better from the inclusion of docker.
    2. Simple setup but terrible documentation :smiley:.
    3. Very limited support for realtime actions like the python interactive console, etc... .

## Problems with this approach.
- You might have noticed that this only help when it comes to program execution. You don't have to have Python or Flask installed on your local machine but for regular coding scenarios like interactive testing, repo pushing, and debugging, docker by itself doesn't offer too much help.

## Solution: Dev Containers
- Dev Containers are almost exactly like you're regular setup but exist as a virtual environment. This means they can be customized and then used as a template for others' use.

- In the bottom right hand corner of your VSCode window you should see a new icon.
![This is what the new icon should look like](./Assets/external_connection_icon.png)
    1. Click it.
    2. A menu of options will pop up. Click *"Reopen in Container"*. Your options may look different depending on your other installed extensions.  ![Menu Option you want](./Assets/devcontainer_option.png)
    - **Make sure your VSCode is open in the folder containing the source code (docker-devcontainer-demo). If you're unsure or seeing errors reopen VSCode in the _'docker-devcontainer-demo'_ folder**
        - You should also see a prompt that asks you if you'd like to reopen the folder in the dev container if you're in the correct folder.

- This may take a moment to load as the container has to read and execute all the instructions for setup.

- Note the console output. Though the startup script itself doesn't do much, the fact that it can be done is **really helpful**. Take a look around, see how similar the environment is to what you regularly use. If not, edit the dockerfile to install new packages, shells, compilers, etc... .

- Try these out in the terminal to explore the capabilities:
    1. Run `cd ~/flaskapp`, then `scripts/runSite.sh`. This should start the site yet again at [localhost:4002](http://localhost:4002). Note: [localhost:4001](http://localhost:4001) is running the same site because I was too lazy to find a workaround. _`Control + C` to exit_.
    2. Run `python` to use the interactive cli. Useful for quick testing. _`exit()` or `Control+D` to exit_.
    3. Run `python console_app.py` to run a more tradition command line program.
    4. Run `doxygen`. This will update the 'documentation' folder. Open documentation/html then, find and **open** 'index.html'. Right-Click on it then select "Open with Live Server".
    ![example](./Assets/doxygen_instructions.png)


- Pros: 
    1. Extensions, packages, language compilers, coding helpers, etc... An entire environment can be setup to develop, test, and execute code. 
    2. OS and other system differences are also minimized because all members will be using linux.
    3. Minimal setup required past original dockerfiles.
    4. Setup once, and use forever. No real maintenance required.

- Cons: 
    1. May require one-time setup troubleshooting. Especially when it comes to git configuration. 
        - Helpful commands: `ssh-add {ssh_id filename}` on UNIX
