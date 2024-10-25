class Person {
  String name;
  String gender;
  String zodiac;

  Person({
    required this.name,
    required this.gender,
    required this.zodiac,
  });
}

List<Person> people = [
  Person(name: 'Lê Trần Cát Lâm', gender: 'Male', zodiac: 'Aries'),
  Person(name: 'Trần Thị Ngọc', gender: 'Female', zodiac: 'Aries'),
  Person(name: 'Lê Nguyễn Gia Bảo', gender: 'Male', zodiac: 'Taurus'),
  Person(name: 'Lê Thị Thắm', gender: 'Female', zodiac: 'Taurus'),
  Person(name: 'Đỗ Tuấn Khải', gender: 'Male', zodiac: 'Gemini'),
  Person(name: 'Ngô Lan Hương', gender: 'Female', zodiac: 'Gemini'),
  Person(name: 'Hoàng Văn Chiến', gender: 'Male', zodiac: 'Cancer'),
  Person(name: 'Nguyễn Kim', gender: 'Female', zodiac: 'Cancer'),
];
