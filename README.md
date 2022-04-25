# Quick start

`$ composer create-project linnovate/openideal-composer YOUR_PROJECT_NAME`

Composer will create a new directory called YOUR_PROJECT_NAME,
then you will need to install OpenideaL like you would any other Drupal site.

## Development

#### Configuration management

To export some changes from database to sync directory please use the following command:
`drupal config:export --remove-uuid --remove-config-hash --directory=profiles/contrib/idea/config/install`

There are two ways to pull and apply the latest changes:

1. By performing a new installation (see "Quick start" section).

2. By pulling new changes from git repo and importing new changes from sync directory to the database:
   `drush cim --partial --source="profiles/contrib/idea/config/install"`

3. In non-development mode please manage configuration via `drush cim` and `drush cex` commands.

#### Troubleshooting

1. Make sure the composer has been installed on your local machine, otherwise you need to install
   the [composer](https://getcomposer.org/) before site installation
2. Please make sure you don't have the following files in the config directory before importing configs via Drush:

- core.extension.yml
- system.site.yml
