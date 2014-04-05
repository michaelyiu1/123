// ---- Mesh Size options ----//
lc_gen = 300.000000;
// ---Point Coordinates--------//
Point() = {// ---Lines indices--------//
Line() = {// ---Polygons--------//
Plane Surface(1) = {0};
Point{} In Surface{Line{} In Surface{// ---Attractors and Thresholds--------//
// ---- Other Mesh options ----//
Mesh.ElementOrder = 1;
Mesh.CharacteristicLengthExtendFromBoundary = 0;
Mesh.CharacteristicLengthFromPoints = 0;
Mesh.CharacteristicLengthFromCurvature = 0;
Mesh.CharacteristicLengthMax = 300.000000;
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
