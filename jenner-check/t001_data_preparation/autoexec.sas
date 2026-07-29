/* cap input rows for the captured run */
options obs=100;
/* the categorical columns carry names that need VALIDVARNAME=ANY-friendly
   handling; keep the original data-prep option set from the source repo */
options VALIDMEMNAME=EXTEND VALIDVARNAME=ANY;
