# musinsa

## 기능구현

- JSON 파싱하여 리스트 구현
  - BannerSection
  - GridSection
  - ScrollSection
  - StyleSection
- "더보기"버튼 터치 시 콘텐츠와 버튼 사이로 콘텐츠 추가
- "새로고침"버튼 터치 시 노출된 콘텐츠가 새로고침 되어 랜덤하게 변경



| BannerSection                                                | GridSection                                                  | ScrollSection                                                | StyleSection                                                 |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![](https://tva1.sinaimg.cn/large/e6c9d24egy1h4a020t3zkg20gf0zkqv8.gif) | ![](https://tva1.sinaimg.cn/large/e6c9d24egy1h4a02l22teg20gf0zkh0y.gif) | ![](https://tva1.sinaimg.cn/large/e6c9d24egy1h4a02trgnxg20gf0zkb2a.gif) | ![](https://tva1.sinaimg.cn/large/e6c9d24egy1h4a02zmlr0g20gf0zk1ky.gif) |



## 고민

1. 구조문제
   - 초기 설계시 뷰의 구조가 복잡하지 않다고 판단 -> MVC로 구현
   - "더보기", "새로고침" 기능 구현시 MVC구조로는 한계가 명확하여 MVVM으로 구조 변경
   - 각 계층의 ViewModel을 상위 객체가 생성하여 주입하게 함으로써 상위객체가 하위객체에 `bind`로 접근할 수 있도록 변경
2. `BannerSection`의 page라벨  구현문제
   - 초기 `BannerCell`에 `pageLabel`을 두어 표현
   - cell 이동시 `pageLabel`도 함께 이동하여 사용자 경험이 저하된다고 판단.
   - `BannerCell` 에서 분리 및 `UICollectionReusableView` 로 커스텀하여 구현
   - `UICollectionReusableView`의 경우 reload / cell의 IndexPath에 접근하기 쉽지않다고 판단.
   - `NSCollectionLayoutSection`의 `.visibleItemsInvalidationHandler` 메소드를 사용하여 cell의 프레임에 따라 page가 결정되도록 구현

