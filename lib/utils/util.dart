/*
* 格式化数量
* {int} 数量
*  */
formatCounter(int counter) {
  String counterStr = counter.toString();
  String count;
  if (counterStr.length < 6) {
    count = counterStr;
  } else if (counterStr.length >= 6 && counterStr.length <= 8) {
    String temp = (int.parse(counterStr) / 10000).toStringAsFixed(2);
    List<String> tempList = temp.split('.');
    if (tempList[1] == '00') {
      temp = tempList[0];
    }
    count = temp + 'w';
  } else if (counterStr.length > 8) {
    String temp = (int.parse(counterStr) / 100000000).toStringAsFixed(2);
    count = temp + '亿';
  }

  return count;
}

/*
* 时间格式化
* 1:03 -> 01:03
* */
formatDate(String duration) {
  List<String> durationArr = duration.split('.');
  String durationMinute = durationArr[0].length > 1 ? '${ durationArr[0] } :' : '0${ durationArr[0] }:' ;
  durationMinute += durationArr[1].length > 1 ? durationArr[1] : '0 ${ durationArr[1] }';

  return durationMinute;
}