
import 'dart:io';
import 'dart:math';

void main(dynamic name) async {
print('캐릭터의 이름을 입력하세요:');
  String? name = stdin.readLineSync();
  if (name == null || name.isEmpty || !RegExp(r'^[a-zA-Z가-힣]+$').hasMatch(name)) {
    print('잘못된 이름입니다.');
    return;
  }

    final file = File('characters.txt');
    final contents = file.readAsStringSync();
    final stats = contents.split(',');
    if (stats.length != 3) throw FormatException('worng format');

    int HP = int.parse(stats[0]);
    int attackdamage = int.parse(stats[1]);
    int armor = int.parse(stats[2]);

    Character character = Character(name, HP, attackdamage, armor);
    Game game = Game(character);
    game.startGame();
    game.getRandomMonster();
    game.battle(Monster(name, HP, attackdamage, armor));

    
}

class Character {
  Character(this.name, this.HP, this.attackdamage, this.armor);

  String name;
  int HP;
  int attackdamage;
  int armor;

  void attcackMosters(Monster monster) { //몬스터 공격
  monster.HP -= attackdamage;
  print ('${monster.name}에게 $attackdamage 만큼의 피해를 입혔습니다.');
  }

  void defense(dynamic character, dynamic monster) { //방어
  int heal = 10;
  int luck;
  Random random = Random();
  luck = random.nextInt(3);
  if (luck == 1) {
    heal = 10;
  }else{
    heal = 0;
  }
  character.HP += heal;
  print ('${character.name}이(가) 방어태세를 취하여 $heal 만큼의 체력을 얻었습니다.');

  } 

  void showStatus() { //캐릭터 상태 출력
  if(HP <0) {
    HP = 0;
    print('$name이(가) 사망하였습니다.');
  }else{
  print('$name - 체력 : $HP, 공격력 : $attackdamage, 방어력 : $armor');
  }
  } 

}

class Monster {
  Monster(this.name, this.HP, this.attackdamage, this.armor);

  String name;
  int HP;
  int attackdamage;   //랜덤으로 지정할 공격력 범위 최대값 몬스터 공격력은 캐릭터의 방어력보다 작을 수 없음.
  int armor = 0;

  void attcackCharacter(Character character) { //캐릭터 공격
  int heal = 10;
  int luck;
  Random random = Random();
  luck = random.nextInt(3);
  if (luck == 1) {
    heal = 10;
  }else{
    heal = 0;
  }
  character.HP -= (attackdamage-armor-heal);
  print ('${character.name}이 ${name} 에게 ${attackdamage-armor-heal} 만큼의 피해를 입혔습니다.');
  }

  void showStatus() { //몬스터 상태 출력
  if(HP <0) {
    HP = 0;
  }
  print('$name - 체력 : $HP, 공격력 : $attackdamage, 방어력 : $armor');
  } 

}

class Game {
  Game(this.character);

  Character character;
  List<Monster> monsters = [];
  int deadMostersNum = 0;
  
  void startGame() {
    //게임 시작, 캐릭터 체력 0 이 게임 종료, 몬스터 대결 유무 체크 설정 몬스터 처치시 게임 승리
    print('게임을 시작합니다.');
    character.showStatus();

  }

  void getRandomMonster() { //Random()사용 몬스터 반환, 대결
    final file = File('monsters.txt');
    final lines = file.readAsLinesSync();
    
    if (lines.isEmpty) {  //몬스터 데이터 유무 체크 
      print('몬스터 데이터가 없습니다.');
      return;
    }else {
      print ('새로운 몬스터가 나타났습니다.');
      print ('');
    }

    Random random = Random();
    int randomNum = random.nextInt(2);

    var selectedMonster = lines[randomNum].split(',');
    String name = selectedMonster[0];
    int health = int.parse(selectedMonster[1]);
    int maxAttack = int.parse(selectedMonster[2]);
    
    print('$name, $health, $maxAttack');

    return monsters.add(Monster(name, health, maxAttack,0));

  }

  void battle(dynamic monster) {   //행동 선택 1.공격 2.방어, 매턴마다 몬스터는 사용자 공격, 몬스 리트 중 랜덤으로 선택 대결, 처치 몬스터 삭제 캐릭터 체력 누적.
    
    while(character.HP > 0 && monsters.isNotEmpty){
    
    while (character.HP > 0 && monster.HP > 0) {
      if(character.HP <=0) {
        break;
      }
    print('');
    print('${character.name} 의 턴');
    print('행동을 선택하세요(1: 공격 2: 방어)');

    String? action = stdin.readLineSync();
    if (action == '1') {
      if (monsters.isNotEmpty) {
        character.attcackMosters(monsters[0]);
      } else {
        print('No monsters to attack.');
      }
    } else if (action == '2') {
      if (monsters.isNotEmpty) {
        character.defense(character, monsters[0]);
      } else {
        print('No monsters to defend against.');
      }
    } else {
      print('잘못된 입력입니다.');
    }
    if(monsters[0].HP <= 0) {
      print('${monsters[0].name}을 처치했습니다.');
      monsters.removeAt(0);
      deadMostersNum++;
      break;
    }
    print('');
    print('${monsters[0].name} 의 턴');
    monsters[0].attcackCharacter(character);
    character.showStatus();
    monsters[0].showStatus();
    
    
    } 
      if(character.HP <=0) {
        break;
      }

  print('다음 몬스터와 싸우시겠습니까? (y/n)');
  String? conti = stdin.readLineSync();
  if (conti == 'y') {
    getRandomMonster();
  } else if (conti == 'n') {
    print('게임을 종료합니다.');
    break;
  } else {
    print('잘못된 입력입니다.');
    
  } 
    

    
    }

  }
}
