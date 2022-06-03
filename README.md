# Welcome to Localizer!

Localizer is a simple tool for search your strings not localized in your project.

## How to use

To launch the tool, only write in your terminal (-h if you want see a list with subcommands):
````
localizer -p <Your proyect path> -l <Your localizables path>
````

# Options

**-p** or **--proyect-path**: Your project directory

**-l** or **--localizable-file-path**: Your localizable directory

**-r** or **--reverse-localizable**: Be default is ```false```, you match your localizables with your project localizables. Set this parameter to ```true``` if you want match your project localizables with your localizable strings.

**-s** or **--show-unused-keys**: Is ```false``` be default. You can use this parameters if you want see your unused localizables.


