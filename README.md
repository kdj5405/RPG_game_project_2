Dart RPG Game

📌 개요

Dart로 제작한 간단한 텍스트 기반 RPG 게임입니다. 사용자는 캐릭터를 생성하고, 랜덤으로 등장하는 몬스터들과 전투를 진행할 수 있습니다. 게임의 진행은 콘솔을 통해 이루어지며, 캐릭터와 몬스터의 데이터는 외부 파일에서 로드됩니다.

🛠️ 기능

✅ 게임 주요 기능

랜덤 전투 시스템: Random()을 이용해 랜덤한 몬스터를 소환하여 전투 진행

파일 입출력: characters.txt와 monsters.txt에서 데이터를 불러와 사용

객체 지향 구조: Character, Monster, Game 클래스를 활용하여 관리

사용자 입력 처리: 플레이어가 공격 또는 방어를 선택하며 게임 진행

게임 승리/패배 조건: 체력이 0 이하가 되면 패배, 모든 몬스터를 처치하면 승리

📂 파일 설명

game.dart → RPG 게임의 실행 코드

characters.txt → 캐릭터 기본 능력치 (체력, 공격력, 방어력) 저장

monsters.txt → 몬스터 정보 (이름, 체력, 최대 공격력) 저장

📜 게임 규칙

플레이어는 게임 시작 시 캐릭터 이름을 입력합니다.

랜덤한 몬스터가 선택되어 전투가 시작됩니다.

플레이어는 매 턴마다 **공격(1) 또는 방어(2)**를 선택합니다.

공격 시:

캐릭터가 몬스터에게 피해를 줍니다.

몬스터가 체력이 남아있다면, 반격합니다.

방어 시:

캐릭터의 체력이 약간 회복됩니다.

몬스터의 공격을 일정 부분 방어합니다.

몬스터를 처치하면 다음 몬스터와 싸울지 선택할 수 있습니다.

캐릭터의 체력이 0이 되면 게임 오버.

🚀 실행 방법

1️⃣ 프로젝트 클론 또는 생성

2️⃣ characters.txt 및 monsters.txt 생성

characters.txt 예시

monsters.txt 예시

3️⃣ 게임 실행