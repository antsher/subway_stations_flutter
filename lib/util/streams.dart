import 'package:async/async.dart';
import 'package:tuple/tuple.dart';

Stream<Tuple2<T1, T2>> zipTwo<T1, T2>(Stream<T1> stream1, Stream<T2> stream2) =>
    StreamZip([stream1, stream2])
        .map((zipped) => Tuple2<T1, T2>(zipped[0], zipped[1]));

Stream<Tuple3<T1, T2, T3>> zipThree<T1, T2, T3>(
        Stream<T1> stream1, Stream<T2> stream2, Stream<T3> stream3) =>
    StreamZip([stream1, stream2])
        .map((zipped) => Tuple3<T1, T2, T3>(zipped[0], zipped[1], zipped[3]));

Stream<Tuple4<T1, T2, T3, T4>> zipFour<T1, T2, T3, T4>(Stream<T1> stream1,
        Stream<T2> stream2, Stream<T3> stream3, Stream<T4> stream4) =>
    StreamZip([stream1, stream2]).map((zipped) =>
        Tuple4<T1, T2, T3, T4>(zipped[0], zipped[1], zipped[3], zipped[4]));
