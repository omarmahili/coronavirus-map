<p align="center">
    <img src="./android/app/src/main/res/mipmap-mdpi/ic_splashscreen.png" alt="Coronavirus Map" />
</p>

During lockdown I had plenty of time and I wanted to learn flutter, so I developed this app. On April I published it for free on the Play Store, but unfortunately it turned out I was not allowed to publish such apps, so it was suspended.

## Main Features

- Visualization of COVID-19 pandemic data, by country, on the world map
- Draggable sheet with a table of countries and their pandemic data
- Dropdown that filters countries by continent in both map and table with overall stats
- Search bar to search countries by name
- Zoom to country on tap of a table row
- Italian and English translations

App tested on **Android only**

## Demo

![Demo gif](./demo.gif)

## Datasource

The data is provided by the Johns Hopkins University for educational and academic research purposes. For additional information please visit [this page](https://github.com/CSSEGISandData/COVID-19). The Johns Hopkins University disclaims any and all representations and warranties, including accuracy, fitness for use and merchantability. Reliance to data for medical guidance or use in commerce is strictly prohibited. The data shown in the app could differ from that provided by the Johns Hopkins University since processed to provide some features. For any bug or problem please open an issue.

## Contributions

If you want to help in the development of this app please open a PR, while if you find any problem open an issue.

## Run and build project

You can download the bundle or apks from the [releases](https://github.com/omarmahili/coronavirus-map/releases) page.
Otherwise if you want to debug the application clone the repository and run:

> flutter pub get

Then:

> flutter run

To build and release the app follow the documentation [here](https://flutter.dev/docs/deployment/android).

## License

This work by Omar Mahili is licensed under CC BY-NC-SA 4.0. <br />
To view a copy of this license, visit https://creativecommons.org/licenses/by-nc-sa/4.0

### [Dependencies and resources licenses](./assets/licenses/licenses.html)
