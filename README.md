# Onban

**Onban API를 통해 반찬 가게 어플의 홈 화면과 상세 화면 기능 구현**
<br>

## 🎯 프로젝트 목표

```
    1. MVVM-C + CleanArchitecture 적용 (Coordinator 패턴 학습)
    2. RxSwift 및 Input/Output 패턴 적용 (Rx 관련 프레임워크 활용)
    3. Then, SnapKit, Moya 등의 프레임워크 학습
```
<br>

## 🙊 목표 선정 이유
- ViewController의 책임을 덜기 위해 MVVM 패턴을 사용하였으니, 화면 전환에 대한 책임도 덜면서 VC를 생성할 때 필요한 것들을 Coordinator에서 주입 가능하여 DI에 대한 해결 가능
- 비동기 작업의 편의성을 위한 Rx, 코드로 뷰를 작성하는 데 편리함을 주는 Then, SnapKit 등의 프레임워크에 대한 학습 및 연습
- 학습을 위해 작은 단위로 프로젝트 구성

<br>

## 📝 화면 개요
|   메인 화면    |   상세 화면   |
| :----------: | :--------: |
|  <img src="https://user-images.githubusercontent.com/44107696/199626797-136ba423-0b15-496d-a9c2-903a72703608.gif" width="200"> | <img src="" width="200"> |
|   스크롤과 서브설명 셀 선택 시, 상세설명 이동    |   상세 화면 구현 시 추가   |

## ⚙️ 개발 환경


[![Swift](https://img.shields.io/badge/swift-v5.5-orange?logo=swift)](https://developer.apple.com/kr/swift/)
[![Xcode](https://img.shields.io/badge/xcode-v14.0-blue?logo=xcode)](https://developer.apple.com/kr/xcode/)
[![RxSwift](https://img.shields.io/badge/RxSwift-6.5.0-red)]()
[![Moya](https://img.shields.io/badge/Moya-15.0-red)]()
<img src="https://img.shields.io/badge/UIkit-000000?style=flat&logo=UIkit" alt="uikit" maxWidth="100%">


<br>

## 🌟 고민과 해결

### 🔅 메인 화면
#### 1. Coordinator 설정

| 개념 도식도
![](https://i.imgur.com/6yyEnZH.png)

- 고민 사항
    - 메인 화면이 TabBarVC라 `start()` 함수 호출 시, 어떤 작업들을 진행해주어야 할 지에 대한 고민이 생김
    - `start()` 함수가 Coordinator의 생성을 맡아야 할 지, 실질적인 VC를 생성해서 push 하는 부분까지 맡아야 할 지 감을 잡지 못 하였음

- 해결
    - AppCoordinator는 따로 VC를 생성할 것이 없기에 MainCoordinator를 child로 생성하고 `start()`를 호출하도록 구현 (로그인이 있을 경우에는 AppCoordinator의 기능이 추가)
    - MainCoordinator는 `start()`가 호출되면 TabBarVC 생성과 함께 각 탭에 필요한 Coordinator들을 생성하여 child로 추가하고, 하위 Coordinator의 `start()` 함수를 호출
    - 하위 탭의 Coordinator들은 NavigationController를 각각 생성하고 그 위에 담당 VC들을 생성(DI 진행)하여 push
    - 차후 하위 탭 Coordinator에서 상세 화면이나 다른 뷰로의 이동이 필요할 경우에는 delegate를 추가로 생성해서 필요한 Coordinator에 채택하여 push/pop 로직 진행

#### 2. CollectionView reuse cell
- 고민 사항
    - RxCocoa의 `collectionView.rx.items(cellIdentifier:, cellType:)`를 통해 cell이 재사용되던 중, 이벤트 뱃지가 원하지 않는 셀에도 추가되는 등의 문제가 발생

- 해결
    - 처음에는 RxCocoa의 해당 메서드에 대한 문제로 파악하여 RxDatasources를 활용해보는 등의 작업을 진행하였으나 별다른 효과가 없음
    - 이후 셀이 재사용되기 때문에 재사용되는 셀의 UI 요소 외의 것을 비워줘야한다는 것을 깨달았고 `prepareForReuse()`를 오버라이드하여 데이터를 지워주는 로직을 추가

#### 3. CollectionView cell setting UIImage
- 고민 사항
    - RxCocoa의 `collectionView.rx.items(cellIdentifier:, cellType:)`를 통해 cell을 생성할 때, String 타입으로 받은 url을 통해 이미지로 변환해서 적절한 cell에 넣는 로직에 대한 고민 발생
    - 초기 해결 방향
        - 처음에는 usecase에서 repository로부터 DTO를 받아오면 `shared()`를 통해 변환된 entity와 urlString을 Data 타입으로 바꿔주는 로직으로 한 번에 보내주고, 해당 값들을 각각의 subject에 뿌려주고 `collecitonView.rx`가 적절하게 캐치하여 UI에 반영하도록 구현
        - 각각의 subject에`collectionView.rx.items(cellIdentifier:, cellType:)`로 중복 바인딩을 하려했으나 이를 위해서는 동일한 Entity 타입이어야 하다보니 해당 방법으로 해결하기 어려웠음
        - 이외에도 먼저 entity를 받은 뒤에 image 변환 로직을 VM에 호출하고 이후 비동기로 Data를 받은 다음에 cell에 넣어주려고 했으나 dataSource delegate를 사용했을 때와 달리 reload 시점이나 정확한 IndexPath를 알 수 없어 올바른 cell에 이미지를 전달할 수가 없음 

- 해결
    - UIImageView를 extension하여 String을 받아 url과 Data로 변환하여 이를 자신의 image에다가 할당하는 로직을 추가
        ```swift
        extension UIImageView {

            func load(with urlString: String) {
                guard let url = URL(string: urlString) else { return }

                DispatchQueue.global().async { [weak self] in
                    guard let data = try? Data(contentsOf: url) else { return }

                    DispatchQueue.main.async {
                        self?.image = UIImage(data: data)
                    }
                }
            }
        }
        ```
    - usecase에서 repository의 DTO를 Entity로 변환하는 로직에서 먼저 메모리나 디스크에 이미지 Data 캐시 확인을 진행 후, 없을 경우에는 캐싱을 진행함과 동시에 Data없이 urlString만 있는 Entity로 변환해서 넘겨주도록 구현 (Entity에 Data 타입 할당할 옵셔널 프로퍼티 추가)
    - cell의 `setFoodImage(imageData: Data?, urlString: String)`호출하고 imageData가 nil일 경우에는 앞서 위에 작성한 UIImageView extension의 `load(with urlString: String)` 함수를 호출하여 데이터 변환 작업 진행

#### 4. Usecase / Repository protocol
- 고민 사항
    - Usecase나 Repository의 경우 VM이나 기능에 따라 프로퍼티나 추가적인 함수들이 필요한 경우가 있으나 통일성이 없어 하나의 Protocol로 대응하기가 어려운 점이 있음

- 해결
    - 가장 기본적인 기능을 제공하는 BasicProtocol을 구현하고, 각 Usecase나 Repository에 필요한 요소를 구현한 신규 Protocol들을 생성한 뒤 BasicProtocol을 채택하도록 구현
--------

### 🔅 상세 화면
