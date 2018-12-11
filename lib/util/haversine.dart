import 'dart:math';

const double EARTH_DIAMETER = 12756274.0;

double distance(
    double latitude1, double latitude2, double longitude1, double longitude2) {
  final lat1 = _radiansFromDegrees(latitude1);
  final lon1 = _radiansFromDegrees(latitude2);
  final lat2 = _radiansFromDegrees(longitude1);
  final lon2 = _radiansFromDegrees(longitude2);

  double distance = EARTH_DIAMETER *
      asin(sqrt(pow(sin(lat2 - lat1) / 2, 2) +
          cos(lat1) * cos(lat2) * pow(sin(lon2 - lon1) / 2, 2)));
  return distance;
}

double _radiansFromDegrees(final double degrees) => degrees * (pi / 180.0);
