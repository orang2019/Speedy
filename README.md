# 뇌과학을 적용한 암기앱
---
# 프로젝트 소개
Project nickname : Speedy (speed + study)  
Project execution period : 2022.04 ~ 2022.09


Speedy는 빠른 암기가 필요한 사람들을 위한 시스템으로, 단기 암기를 장기 암기로 바꿔 오래 기억할 수 있게 만든다.

시장에는 이미 단기암기를 위한 암기앱과 장기 암기를 위한 복습앱이 출시되어 있다. 그러나 하나의 앱에서 암기와 복습을 동시에 해결할 수 있는 앱이 없다.
따라서 단기암기를 장기암기로 바꾸는 체계적인 암기앱이 필요하다.

또한, 빠른 암기를 위해 메타인지를 이용한 타이머를 개발했다.  
해당 타이머를 이용한다면, 답을 말하는 시간을 단축하게 된다. 결국에 문제를 보면 바로 답이 머릿속에 그려지는 효과를 얻게 된다.


# 대표 기능
1. 목표 설정
2. 캘린더로 날짜별 복습할 것 확인하기
3. 타이머로 암기하기


# 사용 방법
1. 상단바에서 목표를 설정한다.
2. TabBar에서 암기한다.

---
### 목표 설정

<img width="650" alt="image" src="https://github.com/orang2019/noteAndfirestore/assets/76255901/c0b0b6fa-8328-4d8c-98d5-9acb7f734bfa">



### 첫 번째 TabBar
오늘 암기할 제목을 확인하고, 재생버튼(▶️)을 눌러 암기한다.  

<img width="651" alt="image" src="https://github.com/orang2019/noteAndfirestore/assets/76255901/08d6713f-c9e4-4ba5-957e-128ceffdfeaf">

<img width="624" alt="image" src="https://github.com/orang2019/noteAndfirestore/assets/76255901/e2de18d9-de12-48c8-b2a3-561c78496d94">




### 두 번째 TabBar
에빙하우스 망각곡선을 이용한 캘린더 이다.  
FAB버튼으로 문제를 만들면, 캘린더에 자동으로 복습할 내용이 채워진다.  

<img width="643" alt="image" src="https://github.com/orang2019/noteAndfirestore/assets/76255901/4965fdc3-d093-413a-b023-f48d65aa09f7">


---

# 시작 가이드

## dependencies

```dart
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^1.10.6
  firebase_auth: ^3.3.4
  cloud_firestore: ^3.1.5
  provider: ^6.0.3
  flutter_slidable: ^2.0.0
  table_calendar: ^3.0.7
  carousel_slider: ^4.1.1
  firebase_messaging: ^13.0.2
  flutter_local_notifications: ^9.9.1
  permission_handler: ^10.0.0
  get: ^4.6.5
  http: ^0.13.5
  cr_calendar: ^1.0.0
  intl: ^0.17.0
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  shared_preferences: ^2.0.15

dev_dependencies:
  build_runner : ^2.3.3
  hive_generator: ^2.0.0
  flutter_test:
    sdk: flutter

```


