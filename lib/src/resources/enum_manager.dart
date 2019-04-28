///
/// Allow us to fetch enum values in json files
/// 
class EnumManager<T> {
  EnumManager(this.map);
  
  Map<String, T> map;
  Map<T, String> reverseMap;

  Map<T, String> get reverse {
      reverseMap ??= reverseMap = map.map((String k, T v) => MapEntry<T, String>(v, k));

      return reverseMap;
  }
}