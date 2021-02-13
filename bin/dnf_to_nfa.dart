import 'dart:io';

void main(List<String> arguments) {
  print('Please enter states count?!');
  final stateCount = int.parse(stdin.readLineSync(retainNewlines: true));
  print('Please enter inputs count?!');
  final charCount = int.parse(stdin.readLineSync(retainNewlines: true));

  final states = <String, Map<String, List<String>>>{};
  final newStates = <String, Map<String, List<String>>>{};
  final inputs = [];
  final statesName = [];
  for (var i = 0; i < charCount; i++) {
    print('enter input ${i + 1}:');
    inputs.add(stdin.readLineSync());
  }
  for (var i = 0; i < stateCount; i++) {
    print('enter state ${i + 1} name:');
    statesName.add(stdin.readLineSync());
    states[statesName[i]] = <String, List<String>>{};
    for (var k = 0; k < charCount; k++) {
      print('Please enter ${statesName[i]} transations with ${inputs[k]}:');
      final paths = stdin.readLineSync().toString().replaceAll(' ', '').trim();
      var l = paths.replaceAll('[', '').replaceAll(']', '').split(',');
      l.remove('');
      l.remove(' ');
      states[statesName[i]][inputs[k]] = l.isEmpty ? [] : l;
    }
  }

  var allStates = [
    getStateName([statesName[0]])
  ];
  var count = 1;
  for (var i = 0; i < count; i++) {
    var names =
        allStates[count - 1].replaceAll('{', '').replaceAll('}', '').split(',');
    for (var j = 0; j < inputs.length; j++) {
      var goToStates = <String>[];
      for (var k = 0; k < names.length; k++) {
        if (states[names[k]] != null) {
          goToStates.addAll(states[names[k]][inputs[j]]);
          var mySname = getStateName(goToStates);
          if (!allStates.contains(mySname) && mySname != '{}') {
            allStates.add(mySname);
            count = allStates.length;
          }
        }
      }
    }
  }
  print('New States : ' + allStates.toString() + '\n');

  allStates.forEach((ch) {
    newStates[ch] = <String, List<String>>{};
    var names = ch.replaceAll('{', '').replaceAll('}', '').split(',');
    for (var j = 0; j < inputs.length; j++) {
      var goToStates = <String>[];
      for (var k = 0; k < names.length; k++) {
        if (states[names[k]] != null) {
          goToStates.addAll(states[names[k]][inputs[j]]);
        }
      }
      newStates[ch][inputs[j]] = goToStates;
    }
  });
  print('Transation Table : ');
  newStates.keys.forEach((ky) {
    print(newStates[ky].toString());
  });
}

String getStateName(List<String> list) {
  var s = '{';
  for (var i = 0; i < list.length; i++) {
    s += list[i];
    if (i != list.length - 1) s += ',';
  }
  s += '}';
  return s;
}
