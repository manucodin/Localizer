# Localizer
[![Platform](https://img.shields.io/bitrise/6c8f879c831767a2?token=OXWkAn3z22ZrCNrMyZrmHw&style=flat-square)](https://cocoapods.org/pods/InstaGallery) [![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square) [![Swift](https://img.shields.io/badge/swift-5.0-red?style=flat-square)](https://cocoapods.org/pods/InstaGallery) [![Platform](https://img.shields.io/badge/platform-ios-blue?style=flat-square)](https://cocoapods.org/pods/InstaGallery) 
Localizer is a simple tool for search your strings not localized in your project.

## How to use

### Create realease and install like command line tool
If you want use localizer like other command line tool, you need create a release version and copy in your local path. Run the next commands:
````
swift build --configuration release
cp -f .build/release/localizer /usr/local/bin/localizer
````

### Using Localizer

To launch the tool, only write in your terminal (-h if you want see a list with subcommands):
````
localizer -p <Your proyect path> -l <Your localizables path>
````

## Options
**-p** or **--proyect-path**: Your project directory

**-l** or **--localizable-file-path**: Your localizable directory

**-r** or **--reverse-localizable**: Be default is ```false```, you match your localizables with your project localizables. Set this parameter to ```true``` if you want match your project localizables with your localizable strings.

**-s** or **--show-unused-keys**: Is ```false``` be default. You can use this parameters if you want see your unused localizables.


