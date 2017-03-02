#include <stdlib.h>
#include <R_ext/Rdynload.h>
#include <R_ext/Visibility.h>

void portal(double * vecmatrix, int * rows, double * vecH, int * vecGridSize, double * vecweight, double * vecestimate,double *vecevalpoints);

static const R_CMethodDef cMethods[]  = {
    {"portal", (DL_FUNC) &portal, 7},
    {NULL, NULL, 0}
};

void attribute_visible R_init_WPKDE(DllInfo *info)
{
	R_registerRoutines(info, cMethods,NULL, NULL, NULL);
	R_useDynamicSymbols(info, FALSE);
}
