// ---- Mesh Size options ----//
lc_gen = 200.000000;
b1_DistMin = 5.000000;
b1_DistMax = 500.000000;
b1_LcMin = 5.000000;
b1_LcMax = 200.000000;
b2_DistMin = 50.000000;
b2_DistMax = 500.000000;
b2_LcMin = 50.000000;
b2_LcMax = 500.000000;
// ---Point Coordinates--------//
Point(1) = {0.000000, 0.000000, 0.000000, lc_gen};
Point(2) = {0.000000, 5000.000000, 0.000000, lc_gen};
Point(3) = {5000.000000, 5000.000000, 0.000000, lc_gen};
Point(4) = {5000.000000, 0.000000, 0.000000, lc_gen};
Point(7) = {844.000000, 1177.000000, 0.000000, b1_LcMin};
Point(8) = {2356.000000, 2829.000000, 0.000000, b1_LcMin};
Point(5) = {2500.000000, 5000.000000, 0.000000, b2_LcMin};
Point(6) = {5000.000000, 2500.000000, 0.000000, b2_LcMin};
// ---Lines indices--------//
Line(1) = {1,2};
Line(2) = {2,5};
Line(3) = {3,6};
Line(4) = {4,1};
Line(5) = {5,3};
Line(6) = {6,4};
Line(7) = {5,6};
// ---Polygons--------//
Line Loop(1) = {1,2,5,3,6,4};
Plane Surface(1) = {1};
Point{1} In Surface{1};
Point{2} In Surface{1};
Point{3} In Surface{1};
Point{4} In Surface{1};
Point{5} In Surface{1};
Point{6} In Surface{1};
Point{7} In Surface{1};
Point{8} In Surface{1};
Line{1} In Surface{1};
Line{2} In Surface{1};
Line{3} In Surface{1};
Line{4} In Surface{1};
Line{5} In Surface{1};
Line{6} In Surface{1};
Line{7} In Surface{1};
// ---Attractors and Thresholds--------//
Field[1] = Attractor;
Field[1].NodesList = {7,8};
Field[3] = Threshold;
Field[3].IField = 1;
Field[3].LcMin = b1_LcMin;
Field[3].LcMax = b1_LcMax;
Field[3].DistMin = b1_DistMin;
Field[3].DistMax = b1_DistMax;
Field[2] = Attractor;
Field[2].NodesList = {5,6};
Field[2].NNodesByEdge = 50.000000;
Field[2].EdgesList = {7};
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
Mesh.ElementOrder = 1;
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
