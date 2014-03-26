import arcpy
import sys
import os
#gp = arcgisscripting.create(9.3)
#import arcpy
def main():
	N=len(sys.argv)
	#print N
	inputlist=["hi"] * (N-3)
    # print command line arguments
	print "The input features are: "
	for index in range(len(sys.argv)):
		if index == 0:
			continue
		if index == N-2:
			break
		inputlist[index-1]=sys.argv[index]+".shp"
		print "    "+sys.argv[index]
		
	#print inputlist[0]
	outputname = sys.argv[N-2]
	print "The temporary file name is: "
	print "    "+outputname
	tol=sys.argv[N-1]
	print "User specified tolerance: "
	print "    "+tol

	
	print "ARCGIS Commands >>>"
	# STEP 1
	print "    "+"FeatureToLine_management ..."
	arcpy.FeatureToLine_management(inputlist,  outputname, tol, "ATTRIBUTES")

	# STEP 2 
	outputname_poly=outputname+"_poly"
	print "    "+"FeatureToPolygon_management ..."
	arcpy.FeatureToPolygon_management(outputname+".shp", outputname_poly, tol, "ATTRIBUTES", "")
	#print outputname_poly

	# STEP 3
	print "    "+"AddField_management ..."
	arcpy.AddField_management(outputname_poly+".shp", "ID_temp", "SHORT")
	outputname_diss=outputname_poly+"_diss"
	#print outputname_diss

	# STEP 4
	print "    "+"Dissolve_management ..."
	arcpy.Dissolve_management(outputname_poly+".shp", outputname_diss, "ID_temp")
	outputname_inter=outputname_diss+"_int"

	# STEP 5
	print "    "+"Intersect_analysis ..."
	arcpy.Intersect_analysis([outputname_diss+".shp", inputlist[0]], outputname_inter, "", tol)
	outputname_AllVerts=outputname+"_allVert"

	# STEP 6
	print "    "+"FeatureVerticesToPoints_management ..."
	arcpy.FeatureVerticesToPoints_management(outputname+".shp", outputname_AllVerts, "ALL")
	

    

if __name__ == "__main__":
    main()