void warning_option_msg(const char *tmp, int i){
	std::cout << "The field " << tmp << " is not defined in the id : " << i << std::endl;
}


// the Matlab version of the validate options function
partoptions validate_options(const mxArray *mat_opt){
const char* sOptions[] = {"Knodes",	"Nal",		"Ngen",		"bed_corr",		"el_order",
							   "el_type", 	"errmax",	"errmin",	"maxstep",		"method",
							   "minstep",   "pornodes",	"search",	"stall_times",	"step",
						       "Nel",		"Np",		"Nsides",	"Nsh",			"Nlay"};

    partoptions opt;
    opt.valid = true;
    double *temp;

    int nOptions, NStructElems;
    nOptions = mxGetNumberOfFields(mat_opt);
	NStructElems = mxGetNumberOfElements(mat_opt);
	//std::cout << "NStructElems " << NStructElems << std::endl;
	//std::cout << "nOptions " << nOptions << std::endl;

	mxArray *tmpval;
	const char *tmp;

	if (NStructElems > 1)
		std::cout << "Option structure has more than one row" << std::endl;
	
    for (int i = 0; i < nOptions; i++)
    {
    	if (i == 0){
    		//check Nal option
    		tmp = mxGetFieldNameByNumber(mat_opt, i);
    		
    		std::string str1 ("Nal");
    		std::string str2 (tmp);
    		if (str1.compare(str2) != 0){
    			warning_option_msg(tmp, i);
    			opt.valid = false;
    			break;
    		}
    		else{
    			tmpval = mxGetField(mat_opt, 0, tmp);
    			temp  = mxGetPr(tmpval);
    			opt.Nal = (int)temp[0];
    			//std::cout << "opt.Nal " << opt.Nal << std::endl;
    			//mxDestroyArray(tmpval);
    		}
    		
    	}

    	if (i == 1){
    		//check search option
    		tmp = mxGetFieldNameByNumber(mat_opt, i);
    		
    		std::string str1 ("search");
    		std::string str2 (tmp);
    		if (str1.compare(str2) != 0){
    			warning_option_msg(tmp, i);
    			opt.valid = false;
    			break;
    		}
    		else{
    			tmpval = mxGetField(mat_opt, 0, tmp);
    			temp  = mxGetPr(tmpval);
    			opt.search = (int)temp[0];
    			//std::cout << "opt.search " << opt.search << std::endl;
    			//mxDestroyArray(tmpval);
    		}
    		
    	}

    	if (i == 2){
    		//check bed_corr option
    		const char *tmp = mxGetFieldNameByNumber(mat_opt, i);

    		std::string str1 ("bed_corr");
    		std::string str2 (tmp);
    		if (str1.compare(str2) != 0){
    			warning_option_msg(tmp, i);
    			opt.valid = false;
    			break;
    		}
    		else{
    			tmpval = mxGetField(mat_opt, 0, tmp);
    			temp  = mxGetPr(tmpval);
    			opt.bed_corr = (bool)temp[0];
    			//std::cout << "opt.bed_corr " << opt.bed_corr << std::endl;
    			//mxDestroyArray(tmpval);
    		}
    	}

    	if (i == 3){
    		//check Knodes option
    		const char *tmp = mxGetFieldNameByNumber(mat_opt, i);
    		
    		std::string str1 ("Knodes");
    		std::string str2 (tmp);
    		if (str1.compare(str2) != 0){
    			warning_option_msg(tmp, i);
    			opt.valid = false;
    			break;
    		}
    		else{
    			tmpval = mxGetField(mat_opt, 0, tmp);
    			temp  = mxGetPr(tmpval);
    			opt.Knodes = (int)temp[0];
    			//std::cout << "opt.Knodes " << opt.Knodes << std::endl;
    			//mxDestroyArray(tmpval);
    		}
    	}

    	if (i == 4){
    		//check step option
    		const char *tmp = mxGetFieldNameByNumber(mat_opt, i);
    		
    		std::string str1 ("step");
    		std::string str2 (tmp);
    		if (str1.compare(str2) != 0){
    			warning_option_msg(tmp, i);
    			opt.valid = false;
    			break;
    		}
    		else{
    			tmpval = mxGetField(mat_opt, 0, tmp);
    			temp  = mxGetPr(tmpval);
    			opt.step = temp[0];
    			//std::cout << "opt.step " << opt.step << std::endl;
    			//mxDestroyArray(tmpval);
    		}
    	}

    	if (i == 5){
    		//check minstep option
    		const char *tmp = mxGetFieldNameByNumber(mat_opt, i);
    		
    		std::string str1 ("minstep");
    		std::string str2 (tmp);
    		if (str1.compare(str2) != 0){
    			warning_option_msg(tmp, i);
    			opt.valid = false;
    			break;
    		}
    		else{
    			tmpval = mxGetField(mat_opt, 0, tmp);
    			temp  = mxGetPr(tmpval);
    			opt.minstep = temp[0];
    			//std::cout << "opt.minstep " << opt.minstep << std::endl;
    			//mxDestroyArray(tmpval);
    		}
    	}

    	if (i == 6){
    		//check errmin option
    		const char *tmp = mxGetFieldNameByNumber(mat_opt, i);
    		
    		std::string str1 ("errmin");
    		std::string str2 (tmp);
    		if (str1.compare(str2) != 0){
    			warning_option_msg(tmp, i);
    			opt.valid = false;
    			break;
    		}
    		else{
    			tmpval = mxGetField(mat_opt, 0, tmp);
    			temp  = mxGetPr(tmpval);
    			opt.errmin = temp[0];
    			//std::cout << "opt.errmin " << opt.errmin << std::endl;
    			//mxDestroyArray(tmpval);
    		}
    	}

    	if (i == 7){
    		//check errmax option
    		const char *tmp = mxGetFieldNameByNumber(mat_opt, i);
    		
    		std::string str1 ("errmax");
    		std::string str2 (tmp);
    		if (str1.compare(str2) != 0){
    			warning_option_msg(tmp, i);
    			opt.valid = false;
    			break;
    		}
    		else{
    			tmpval = mxGetField(mat_opt, 0, tmp);
    			temp  = mxGetPr(tmpval);
    			opt.errmax = temp[0];
    			//std::cout << "opt.errmax " << opt.errmax << std::endl;
    			//mxDestroyArray(tmpval);
    		}
    	}

    	if (i == 8){
    		//check method option
    		const char *tmp = mxGetFieldNameByNumber(mat_opt, i);
    		
    		std::string str1 ("method");
    		std::string str2 (tmp);
    		if (str1.compare(str2) != 0){
    			warning_option_msg(tmp, i);
    			opt.valid = false;
    			break;
    		}
    		else{
    			tmpval = mxGetField(mat_opt, 0, tmp);
    			temp  = mxGetPr(tmpval);
    			opt.method = (int)temp[0];
    			//std::cout << "opt.method " << opt.method << std::endl;
    			//mxDestroyArray(tmpval);
    		}
    	}

    	if (i == 9){
    		//check pornodes option
    		const char *tmp = mxGetFieldNameByNumber(mat_opt, i);
    		
    		std::string str1 ("pornodes");
    		std::string str2 (tmp);
    		if (str1.compare(str2) != 0){
    			warning_option_msg(tmp, i);
    			opt.valid = false;
    			break;
    		}
    		else{
    			tmpval = mxGetField(mat_opt, 0, tmp);
    			temp  = mxGetPr(tmpval);
    			opt.pornodes = (int)temp[0];
    			//std::cout << "opt.pornodes " << opt.pornodes << std::endl;
    			//mxDestroyArray(tmpval);
    		}
    	}

    	if (i == 10){
    		//check porinterp option
    		const char *tmp = mxGetFieldNameByNumber(mat_opt, i);
    		
    		std::string str1 ("porinterp");
    		std::string str2 (tmp);
    		if (str1.compare(str2) != 0){
    			warning_option_msg(tmp, i);
    			opt.valid = false;
    			break;
    		}
    		else{
    			tmpval = mxGetField(mat_opt, 0, tmp);
    			temp  = mxGetPr(tmpval);
    			opt.porinterp = (int)temp[0];
    			//std::cout << "opt.porinterp " << opt.porinterp << std::endl;
    			//mxDestroyArray(tmpval);
    		}
    	}

    	if (i == 11){
    		//check Ngen option
    		const char *tmp = mxGetFieldNameByNumber(mat_opt, i);
    		
    		std::string str1 ("Ngen");
    		std::string str2 (tmp);
    		if (str1.compare(str2) != 0){
    			warning_option_msg(tmp, i);
    			opt.valid = false;
    			break;
    		}
    		else{
    			tmpval = mxGetField(mat_opt, 0, tmp);
    			temp  = mxGetPr(tmpval);
    			opt.Ngen = (int)temp[0];
    			//std::cout << "opt.Ngen " << opt.Ngen << std::endl;
    			//mxDestroyArray(tmpval);
    		}
    	}

    	if (i == 12){
    		//check maxstep option
    		const char *tmp = mxGetFieldNameByNumber(mat_opt, i);
    		
    		std::string str1 ("maxstep");
    		std::string str2 (tmp);
    		if (str1.compare(str2) != 0){
    			warning_option_msg(tmp, i);
    			opt.valid = false;
    			break;
    		}
    		else{
    			tmpval = mxGetField(mat_opt, 0, tmp);
    			temp  = mxGetPr(tmpval);
    			opt.maxstep = temp[0];
    			//std::cout << "opt.maxstep " << opt.maxstep << std::endl;
    			//mxDestroyArray(tmpval);
    		}
    	}

    	if (i == 13){
    		//check stall_times option
    		const char *tmp = mxGetFieldNameByNumber(mat_opt, i);
    		
    		std::string str1 ("stall_times");
    		std::string str2 (tmp);
    		if (str1.compare(str2) != 0){
    			warning_option_msg(tmp, i);
    			opt.valid = false;
    			break;
    		}
    		else{
    			tmpval = mxGetField(mat_opt, 0, tmp);
    			temp  = mxGetPr(tmpval);
    			opt.stall_times = (int)temp[0];
    			//std::cout << "opt.stall_times " << opt.stall_times << std::endl;
    			//mxDestroyArray(tmpval);
    		}
    	}

    	if (i == 14){
    		//check el_type option
    		const char *tmp = mxGetFieldNameByNumber(mat_opt, i);
    		
    		std::string str1 ("el_type");
    		std::string str2 (tmp);
    		if (str1.compare(str2) != 0){
    			warning_option_msg(tmp, i);
    			opt.valid = false;
    			break;
    		}
    		else{
    			tmpval = mxGetField(mat_opt, 0, tmp);
    			temp  = mxGetPr(tmpval);
    			opt.el_type = (int)temp[0];
    			//std::cout << "opt.el_type " << opt.el_type << std::endl;
    			//mxDestroyArray(tmpval);
    		}
    	}

    	if (i == 15){
    		//check el_order option
    		const char *tmp = mxGetFieldNameByNumber(mat_opt, i);
    		
    		std::string str1 ("el_order");
    		std::string str2 (tmp);
    		if (str1.compare(str2) != 0){
    			warning_option_msg(tmp, i);
    			opt.valid = false;
    			break;
    		}
    		else{
    			tmpval = mxGetField(mat_opt, 0, tmp);
    			temp  = mxGetPr(tmpval);
    			opt.el_order = (int)temp[0];
    			//std::cout << "opt.el_order " << opt.el_order << std::endl;
    			//mxDestroyArray(tmpval);
    		}
    	}

    	if (i == 17){
    		//check Nel option
    		const char *tmp = mxGetFieldNameByNumber(mat_opt, i);
    		
    		std::string str1 ("Nel");
    		std::string str2 (tmp);
    		if (str1.compare(str2) != 0){
    			warning_option_msg(tmp, i);
    			opt.valid = false;
    			break;
    		}
    		else{
    			tmpval = mxGetField(mat_opt, 0, tmp);
    			temp  = mxGetPr(tmpval);
    			opt.Nel = (int)temp[0];
    			//std::cout << "opt.Nel " << opt.Nel << std::endl;
    			//mxDestroyArray(tmpval);
    		}
    	}

    	if (i == 18){
    		//check Np option
    		const char *tmp = mxGetFieldNameByNumber(mat_opt, i);
    		
    		std::string str1 ("Np");
    		std::string str2 (tmp);
    		if (str1.compare(str2) != 0){
    			warning_option_msg(tmp, i);
    			opt.valid = false;
    			break;
    		}
    		else{
    			tmpval = mxGetField(mat_opt, 0, tmp);
    			temp  = mxGetPr(tmpval);
    			opt.Np = (int)temp[0];
    			//std::cout << "opt.Np " << opt.Np << std::endl;
    			//mxDestroyArray(tmpval);
    		}
    	}

    	if (i == 19){
    		//check Nsides option
    		const char *tmp = mxGetFieldNameByNumber(mat_opt, i);
    		
    		std::string str1 ("Nsides");
    		std::string str2 (tmp);
    		if (str1.compare(str2) != 0){
    			warning_option_msg(tmp, i);
    			opt.valid = false;
    			break;
    		}
    		else{
    			tmpval = mxGetField(mat_opt, 0, tmp);
    			temp  = mxGetPr(tmpval);
    			opt.Nsides = (int)temp[0];
    			//std::cout << "opt.Nsides " << opt.Nsides << std::endl;
    			//mxDestroyArray(tmpval);
    		}
    	}

    	if (i == 20){
    		//check Nsh option
    		const char *tmp = mxGetFieldNameByNumber(mat_opt, i);
    		
    		std::string str1 ("Nsh");
    		std::string str2 (tmp);
    		if (str1.compare(str2) != 0){
    			warning_option_msg(tmp, i);
    			opt.valid = false;
    			break;
    		}
    		else{
    			tmpval = mxGetField(mat_opt, 0, tmp);
    			temp  = mxGetPr(tmpval);
    			opt.Nsh = (int)temp[0];
    			//std::cout << "opt.Nsh " << opt.Nsh << std::endl;
    			//mxDestroyArray(tmpval);
    		}
    	}

    	if (i == 21){
    		//check Nlay option
    		const char *tmp = mxGetFieldNameByNumber(mat_opt, i);
    		
    		std::string str1 ("Nlay");
    		std::string str2 (tmp);
    		if (str1.compare(str2) != 0){
    			warning_option_msg(tmp, i);
    			opt.valid = false;
    			break;
    		}
    		else{
    			tmpval = mxGetField(mat_opt, 0, tmp);
    			temp  = mxGetPr(tmpval);
    			opt.Nlay = (int)temp[0];
    			//std::cout << "opt.Nlay " << opt.Nlay << std::endl;
    			//mxDestroyArray(tmpval);
    		}
    	}

    	



    }
    return opt;
}

