# Welcome to LocalizaThor!

LocalizaThor is a simple tool to search for strings not located in your project or that you are not using in your string file.

# Launch LocalizaThor

To launch the tool, only write in your terminal (-h if you want see a list with subcommands):
````
localizator -h
````

# Search localizable files

Run the next command in your terminar:
````
localizator search -l <YourLocalizableFilePath> -p <YourProyectPath>
````

**-l** or **--localizable-path**: The directory where your translation files are located

**-p** or **--proyect-path**: For default its the current directory 

**-u**: For default, compare your localizable keys against your coding keys, if you want compare your coding keys against your localizable, send -u

**--show-path**: If you want localizable key path in your proyect