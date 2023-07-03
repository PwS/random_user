# random-user

API Used
```bash 
https://random-data-api.com/api/
```

## Flow

- OnLoadEvent
<img src="https://github.com/PwS/random_user/blob/master/doc/flow/OnLoad.png" alt="OnLoad"/>

- OnRefreshEvent
<img src="https://github.com/PwS/random_user/blob/master/doc/flow/OnRefresh.png" alt="OnRefresh"/>

## Demo

[![Watch the video](Demo)](https://github.com/PwS/random_user/assets/22534596/61b6f67e-ee5b-4fa6-a94f-69cf328c32e9)


## Getting Started

Generate File Syntax
```
flutter packages pub run build_runner build
```

or

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

# Hive TypeID

Model / ObjectName    |  ID
:-------------------- | --------------------
User                  | 0
Employment            | 1
Address               | 2
CreditCard            | 3
Subscription          | 4
Coordinates           | 5
