void clcbtc(double BTC[], double URF[], double LF[], int Ns, int Nt){
	//clcbtc(BTC, URF, LF, Ns, Nt);
	int i, j, k, st;

	for (i = 0; i < Ns; i++){
    	for (j = 0; j< Nt; j++){
    		BTC[i+Ns*j] = 0.0;
        }
    }

	st = 0;
	for (i = 0; i < Nt; i++)
	{
		for (j = 0; j < Ns; j++)
		{
			for (k = st; k < Nt; k++)
			{
				BTC[j+Ns*k]=BTC[j+Ns*k]+URF[j+Ns*(k-st)]*LF[j+Ns*i];
				//BTC[ind(j,k,Ns)] = BTC[ind(j,k,Ns)] + URF[ind(j,k-st,Ns)]*LF[ind(j,i,Ns)];
			}
		}
		st++;
	}
}