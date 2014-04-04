// ---- Mesh Size options ----//
lc_gen = 200.000000;
b1_DistMin = 20.000000;
b1_DistMax = 350.000000;
b1_LcMin = 20.000000;
b1_LcMax = 100.000000;
b2_DistMin = 20.000000;
b2_DistMax = 350.000000;
b2_LcMin = 20.000000;
b2_LcMax = 200.000000;
// ---Point Coordinates--------//
Point(1) = {0.000000, 0.000000, 0.000000, lc_gen};
Point(2) = {1000.000000, 0.000000, 0.000000, lc_gen};
Point(4) = {0.000000, 1000.000000, 0.000000, lc_gen};
Point(3) = {1000.000000, 1000.000000, 0.000000, b1_LcMin};
Point(5) = {800.000000, 1000.000000, 0.000000, b1_LcMin};
Point(6) = {1000.000000, 800.000000, 0.000000, b1_LcMin};
Point(7) = {255.000000, 802.000000, 0.000000, b1_LcMin};
Point(8) = {750.000000, 738.000000, 0.000000, b1_LcMin};
Point(9) = {413.000000, 514.000000, 0.000000, b1_LcMin};
Point(10) = {758.000000, 293.000000, 0.000000, b1_LcMin};
Point(11) = {261.000000, 192.000000, 0.000000, b1_LcMin};
Point(3) = {1000.000000, 1000.000000, 0.000000, b2_LcMin};
Point(5) = {800.000000, 1000.000000, 0.000000, b2_LcMin};
Point(6) = {1000.000000, 800.000000, 0.000000, b2_LcMin};
Point(7) = {255.000000, 802.000000, 0.000000, b2_LcMin};
Point(8) = {750.000000, 738.000000, 0.000000, b2_LcMin};
Point(9) = {413.000000, 514.000000, 0.000000, b2_LcMin};
Point(10) = {758.000000, 293.000000, 0.000000, b2_LcMin};
Point(11) = {261.000000, 192.000000, 0.000000, b2_LcMin};
// ---Lines indices--------//
Line(1) = {1,2};
Line(2) = {2,6};
Line(3) = {3,5};
Line(4) = {4,1};
Line(5) = {5,4};
Line(6) = {6,3};
// ---Polygons--------//
Line Loop(1) = {1,2,6,3,5,4};
Plane Surface(1) = {1};
// ---Attractors and Thresholds--------//
Field[1] = Attractor;
Field[1].NodesList = {7,8,9,10,11};
Field[3] = Threshold;
Field[3].IField = 1;
Field[3].LcMin = b1_LcMin;
Field[3].LcMax = b1_LcMax;
Field[3].DistMin = b1_DistMin;
Field[3].DistMax = b1_DistMax;
Field[2] = Attractor;
Field[2].NodesList = {3,5,6};
Field[2].NNodesByEdge = 20.000000;
Field[2].EdgesList = {3,6};
Field[4] = Threshold;
Field[4].IField = 2;
Field[4].LcMin = b2_LcMin;
Field[4].LcMax = b2_LcMax;
Field[4].DistMin = b2_DistMin;
Field[4].DistMax = b2_DistMax;
Field[5] = Min;
Field[5].FieldsList = {3,4};
Background Field = 5;
// ---- Other Mesh options ----//
Mesh.SubdivisionAlgorithm = 1;
Mesh.RecombineAll = 1;
Mesh.Algorithm = 8;
Mesh.ElementOrder = 2;
Mesh.CharacteristicLengthExtendFromBoundary = 0;
Mesh.CharacteristicLengthFromPoints = 0;
Mesh.CharacteristicLengthFromCurvature = 0;
Mesh.CharacteristicLengthMax = 200.000000;
Mesh.SecondOrderIncomplete = 0;
// ---- Partition options ----//
Mesh.Partitioner = 1;
//Mesh.NbPartitions = 7;
Mesh.ColorCarousel = 3;
Mesh.MshFilePartitioned = 0;
Mesh.ChacoGlobalMethod = 2;
Mesh.ChacoArchitecture = 1;
Mesh.ChacoParamREFINE_MAP = 0;
// ------------------------//
