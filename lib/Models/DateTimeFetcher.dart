DateTime _date = DateTime.now();

String findDate(){
  String currentDate = _date.toString().substring(8,10);
  return currentDate;
}

String findMonth(){
  String currentMonth = _date.toString().substring(5,7);
  switch(currentMonth){
    case '01': 
      return 'Jan';
      break;
    case '02': 
      return 'Feb';
      break;
    case '03': 
      return 'March';
      break;
    case '04': 
      return 'April';
      break;
    case '05': 
      return 'May';
      break;
    case '06': 
      return 'Jun';
      break;
    case '07': 
      return 'Jul';
      break;
    case '08': 
      return 'Aug';
      break;
    case '09': 
      return 'Sept';
      break;
    case '10': 
      return 'Oct';
      break;
    case '11': 
      return 'Nov';
      break;
    case '12': 
      return 'Dec';
      break;
  }
}

String findYear(){
  String currentYear = _date.toString().substring(0,4);
  return currentYear;
}

String findHourTime(){
  String currentHourTime = _date.toString().substring(11,13);
  return currentHourTime;
}

String findMinuteTime(){
  String currentMinuteTime = _date.toString().substring(14,16);
  return currentMinuteTime;
}

String findSecondTime(){
  String currentSecondTime = _date.toString().substring(17,19);
  return currentSecondTime;
}