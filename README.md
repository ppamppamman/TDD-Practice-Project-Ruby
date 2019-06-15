## Explain about Objects
  - user : 자판기를 이용하는 사람 갹채
    - amount : Integer
    - drinks : [Drink, Drink ... ]
  - vending_machine : 자판기 객체
    - drinks : { String : [Drink, Drink, Drink], ... }
    - deposit : Integer
  - money : 화폐 객체
    - value : Integer (by ENUM)
  - drink : 음료수 객체
    - name : String
    - price : Integer

## Ruby Test Case


### Test1 - 음료수 뽑기 케이스 (큰 틀)

    1. 돈을 넣는다.
    2. 음료수를 선택할 수 있다.
    3. 음료수를 선택한다.
    4. 음료수가 나온다.
    5. 잔돈을 반환한다.


### Test2 - 돈 입력/출력 유효성 검사 (1-1)

    1. 선언한 돈 객체의 단위가 맞는지 틀린지 체크
    2. 돈의 단위는 50, 100, 500, 1000, 5000 으로 들어온다.
    3. 반환 단위도 50, 100, 500, 1000, 5000 으로 반환해야한다.
    4. 투입한 금액을 표시한다. (반환 금액이 있는지 없는지 체크한다.)
    5. 입력 이후 잘못 입력되면 경고 메세지를 띄운다. 다시 입력받기. 

### Test3 - 음료수 케이스 유효성 검사 

    1. 투입된 금액이 음료의 가격보다 낮으면 선택할 수 없다.
    2. 투입된 금액이 음료의 가격보다 높으면 선택할 수 있다.