//vending-machine.spec.js
const VM = require("../vending-machine");
require("chai").should();

describe("금액을 투입하면 결과를 출력하는 테스트", function() {
  const vm = new VM();
  it("500원을 투입하면, 현재 금액과 레쓰비를 출력한다", function() {
    let resultMessage = "현재 금액: 500원\n선택 가능한 음료: 래쓰비";
    vm.insert(500).should.be.equal(resultMessage);
  });
  it("500원을 더 투입하면, 현재 금액과 레쓰비,포카리를 출력한다", function() {
    let resultMessage = "현재 금액: 1000원\n선택 가능한 음료: 래쓰비,포카리";
    vm.insert(500).should.be.equal(resultMessage);
  });
});

describe("잘못된 동전, 지폐 테스트", function() {
  const vm = new VM();
  it("문자열('500')을 입력하면 에러를 반환한다", function() {
    vm.insert(500);
    vm.insert("500").should.be.equal("error> 잘못된 입력입니다.");
  });
  it("문자열('test string')을 입력하면 에러를 반환한다", function() {
    vm.insert(500);
    vm.insert("test string").should.be.equal("error> 잘못된 입력입니다.");
  });
});

describe("음료를 선택하면 해당하는 음료와 해당 음료를 제외하고 남은 결과를 출력하는 테스트", function() {
  const vm = new VM();
  vm.insert(1500);
  it("래쓰비를 선택하면 래쓰비와 남은 결과가 나온다", function() {
    let resultMessage = `래쓰비\n현재 금액: 1100원\n선택 가능한 음료: 래쓰비,포카리`;
    vm.getDrink("래쓰비").should.be.equal(resultMessage);
  });
  it("포카리를 선택하면 포카리와 남은 결과가 나온다", function() {
    let resultMessage = `포카리\n현재 금액: 400원\n선택 가능한 음료: 래쓰비`;
    vm.getDrink("포카리").should.be.equal(resultMessage);
  });
});

describe("음료를 선택했는데 금액이 모자라면 에러 메세지를 반환하는 테스트", function() {
  const vm = new VM();
  vm.insert(500);
  it("코카콜라 선택하면 에러 메세지를 반환한다.", function() {
    let resultMessage = "잔액이 부족합니다.";
    vm.getDrink("코카콜라").should.be.equal(resultMessage);
  });
});

describe("남은 금액이 다른 음료를 선택할 수 있는 금액이 아니면 바로 잔돈 반환 테스트", function() {
  const vm = new VM();
  vm.insert(500);
  it("래쓰비를 뽑으면 잔돈 100원이 반환된다", function() {
    let resultMessage = `래쓰비\n100원을 반환합니다.\n현재 금액: 0원\n선택 가능한 음료: `;
    vm.getDrink("래쓰비").should.be.equal(resultMessage);
  });
});
