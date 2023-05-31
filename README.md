# Pokemon Application

This application integrates the [PokeApi](https://pokeapi.co/docs/v2#info) to display a list of pokemon and add them as favorites.

It implementes multiple concerns from a technical perspective.

- ViewComponent to refactor or encapsulate components on the view
- Encapsulation for the PokeApi into its own namespace and easy to extract
- Update the views using Turbo stream + StimulusJS

## Features

- Integrates TailwindCSS
- Integrates with DevContainers from VSCode, which allows you to debug and run the application from within the editor
- Provides extension suggestions for a better development experience
- Uses postgres as the Database
- For the test suite, it integrates RSpec, Capybara and Cuprite
- Allows users to sign up
- Allows users to sign in
- Allows users to search for a pokemon(this is an extension, as the API does not provide this)
- Allows users to mark pokemon as favorites

Use this template as you like and enjoy!

## Development

### Stack

- The whole stack uses [Docker](https://docker.io) to run
- Ruby 3.2.2
- Rails 7.0.4.3
- Database: PostgresSQL v14
- CSS Framework: TailwindCSS
- JS: Hotwire & StimulusJS

### Repository setup

I highly recommend you use [Docker](https://www.docker.com/products/docker-desktop/) to setup the project, as
it will make the setup easier.

Once you have Docker up and running, make sure to install the [Github CLI](https://cli.github.com/) and login through
the following command:

```bash
$ gh auth login
```

**This step is important if you want to use VSCode as your text editor, as some extensions on the project require you to login via Github**

After installing **Docker** and **Github CLI** please you can follow this simple steps:

1. Clone the repository into your local machine:

```bash
$ git clone https://github.com/kurenn/pokemon.git
```

**If you are using VSCode as an editor, you can skip this step, and go to the [Using VSCode](#using-vscode) section.**

2. Build the image, just to make sure everything is fine:

```bash
$ cd pokemon
$ docker compose build development
```

**This process may take quite some time, depending on your machine capabilities and internet connection.**

3. Run the web service in bash mode to get inside the container by using the following command:

```bash
$ docker compose run --rm development bash
```

The command above will create a session inside the container, where you can now run any `rails` or `command` related
to the application.

4. Next, is to create the database

```bash
% rails db:create
```

5. Migrate the databases

```bash
% rails db:migrate
```

### Running the stack for Development

Once you setup the repository, it is really easy to lift the project, simply run:

```bash
$ docker compose up development
[+] Running 3/3
 ⠿ Container pokemon_chrome_1       Recreated                                  10.8s
 ⠿ Container pokemon_postgres_1     Recreated                                   0.7s
 ⠿ Container pokemon_development_1  Recreated
```

This command will start every service attached to the `development` service, in this case, `postgres` and a `chrome`
driver for testing purposes.

It may take a while before you see anything, you can follow the logs of the containers with:

```bash
$ docker compose logs development -f
=> Booting Puma
=> Rails 7.0.4.3 application starting in development
=> Run `bin/rails server --help` for more startup options
Puma starting in single mode...
* Puma version: 5.6.5 (ruby 3.2.2-p0) ("Birdie's Version")
*  Min threads: 5
*  Max threads: 5
*  Environment: development
*          PID: 728
* Listening on http://0.0.0.0:3000
Use Ctrl-C to stop
```

This means the project is up and running, and you can go to [http://localhost:3000](http://localhost:3000) inside
your browser.

### Using VSCode

The repository provides support to work with [Visual Code](https://code.visualstudio.com/) and Docker,
using [Dev Containers](https://code.visualstudio.com/docs/remote/containers). I highly recommend you read this last URL.

**If you are using Windows, make sure you have [WSL2 & Docker](https://docs.docker.com/desktop/windows/wsl/) setup**

Once you have VSCode installed, fire up a terminal and run:

```bash
$ cd pokemon
$ code .
```

This will open visual code, prompting you a window, asking you to open the code inside a container.

1. Click the "Open in Container" button

The VS Code window (instance) will reload, clone the source code, and start building the dev container. A progress notification provides status updates.

![Dev Container Progress](https://code.visualstudio.com/assets/docs/remote/containers/dev-container-progress.png)

This process may take quite a few time, you have enough to enjoy a cup of coffee.

Once the process is done, you should be able to see the code on the left pane. But also you'll be prompted with a list
of recommended extensions that will enhance your development experience. We highly recommend you install those. Checkout the [devcontainer.json](.devcontainer/devcontainer.json) to see more on the configuration.

2. Open up a built-in terminal, you should be able to run any command related to the code, in this case to create
   and migrate the databases:

```bash
you@b9ed19405bc7:/workspaces/pokemon$ rails db:create db:migrate
```

3. You now can fire up the server by clicking on the **green** play button under the **Run and Debug** left pane option.

This will open up the built-in terminal and show you the logs for the server.

### Debugging

Ruby 3 comes with a built-in debugger, as part of its standard library, so we will use that.

#### Using VSCode

You can just add a break point on the editor, and the debugger will prompt a `DEBUG CONSOLE` when it tries to execute
the code, and from there, you can input variables or any code you need to.

#### Not using VSCode

While having the `development` container running the `rails server` command, you just need to add the `debugger` instruction
wherever you want to stop the execution, and then attach to the container like so:

```bash
$ docker attach pokemon_development_1
```

This will display the logs from the rails app, as well as give you access to stop the execution on the debugging point as you would expect.

**Take note that if you kill this process you will kill the web service, and you will probably need to lift it up again.**

### Running specs

You can easily run the specs, you just need to have a `development` or `tests` container running, whether is through
VSCode or directly from the terminal

```bash
$ rspec
```

For system specs, we use the tutorial by [Evil Martians](https://evilmartians.com), you can and should read more about
that [here](https://evilmartians.com/chronicles/system-of-a-test-setting-up-end-to-end-rails-testing)
