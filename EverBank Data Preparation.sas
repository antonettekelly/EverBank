session server;

/* Start checking for existence of each input table */
exists0=doesTableExist("CASUSER(kelly.mae@student.umn.ac.id)", "EVERBANK_DATASET");
if exists0 == 0 then do;
  print "Table "||"CASUSER(kelly.mae@student.umn.ac.id)"||"."||"EVERBANK_DATASET" || " does not exist.";
  print "UserErrorCode: 100";
  exit 1;
end;
print "Input table: "||"CASUSER(kelly.mae@student.umn.ac.id)"||"."||"EVERBANK_DATASET"||" found.";
/* End checking for existence of each input table */


  _dp_inputTable="EVERBANK_DATASET";
  _dp_inputCaslib="CASUSER(kelly.mae@student.umn.ac.id)";

  _dp_outputTable="81c148af-5b40-40e2-8381-ba8537e445af";
  _dp_outputCaslib="CASUSER(kelly.mae@student.umn.ac.id)";

dataStep.runCode result=r status=rc / code='/* BEGIN data step with the output table                                           data */
data "81c148af-5b40-40e2-8381-ba8537e445af" (caslib="CASUSER(kelly.mae@student.umn.ac.id)" label="00000051428 KellyMae" promote="no");


    /* Set the input                                                                set */
    set "EVERBANK_DATASET" (caslib="CASUSER(kelly.mae@student.umn.ac.id)"  );

    /* BEGIN statement 192d33e0_da9c_4744_8ec9_c78725f2bd49               dqstandardize */
    "job"n = dqstandardize ("job"n, "Business Title", "ENUSA");
    /* END statement 192d33e0_da9c_4744_8ec9_c78725f2bd49                 dqstandardize */

    /* BEGIN statement 192d33e0_da9c_4744_8ec9_c78725f2bd49               dqstandardize */
    "marital"n = dqstandardize ("marital"n, "Address", "ENUSA");
    /* END statement 192d33e0_da9c_4744_8ec9_c78725f2bd49                 dqstandardize */

    /* BEGIN statement 192d33e0_da9c_4744_8ec9_c78725f2bd49               dqstandardize */
    "education"n = dqstandardize ("education"n, "Organization", "ENUSA");
    /* END statement 192d33e0_da9c_4744_8ec9_c78725f2bd49                 dqstandardize */

    /* BEGIN statement 192d33e0_da9c_4744_8ec9_c78725f2bd49               dqstandardize */
    "default"n = dqstandardize ("default"n, "Address", "ENUSA");
    /* END statement 192d33e0_da9c_4744_8ec9_c78725f2bd49                 dqstandardize */

    /* BEGIN statement 192d33e0_da9c_4744_8ec9_c78725f2bd49               dqstandardize */
    "housing"n = dqstandardize ("housing"n, "Address", "ENUSA");
    /* END statement 192d33e0_da9c_4744_8ec9_c78725f2bd49                 dqstandardize */

    /* BEGIN statement 192d33e0_da9c_4744_8ec9_c78725f2bd49               dqstandardize */
    "loan"n = dqstandardize ("loan"n, "Address", "ENUSA");
    /* END statement 192d33e0_da9c_4744_8ec9_c78725f2bd49                 dqstandardize */

    /* BEGIN statement 192d33e0_da9c_4744_8ec9_c78725f2bd49               dqstandardize */
    "contact"n = dqstandardize ("contact"n, "Name", "ENUSA");
    /* END statement 192d33e0_da9c_4744_8ec9_c78725f2bd49                 dqstandardize */

    /* BEGIN statement 192d33e0_da9c_4744_8ec9_c78725f2bd49               dqstandardize */
    "month"n = dqstandardize ("month"n, "Name", "ENUSA");
    /* END statement 192d33e0_da9c_4744_8ec9_c78725f2bd49                 dqstandardize */

    /* BEGIN statement 192d33e0_da9c_4744_8ec9_c78725f2bd49               dqstandardize */
    "day_of_week"n = dqstandardize ("day_of_week"n, "Name", "ENUSA");
    /* END statement 192d33e0_da9c_4744_8ec9_c78725f2bd49                 dqstandardize */

    /* BEGIN statement 192d33e0_da9c_4744_8ec9_c78725f2bd49               dqstandardize */
    "poutcome"n = dqstandardize ("poutcome"n, "Address", "ENUSA");
    /* END statement 192d33e0_da9c_4744_8ec9_c78725f2bd49                 dqstandardize */

    /* BEGIN statement 192d33e0_da9c_4744_8ec9_c78725f2bd49               dqstandardize */
    "y"n = dqstandardize ("y"n, "Address", "ENUSA");
    /* END statement 192d33e0_da9c_4744_8ec9_c78725f2bd49                 dqstandardize */

/* END data step                                                                    run */
run;
';
if rc.statusCode != 0 then do;
  print "Error executing datastep";
  exit 2;
end;
  _dp_inputTable="81c148af-5b40-40e2-8381-ba8537e445af";
  _dp_inputCaslib="CASUSER(kelly.mae@student.umn.ac.id)";

  _dp_outputTable="EVERBANK_DATASET_00000051428";
  _dp_outputCaslib="CASUSER(kelly.mae@student.umn.ac.id)";

srcCasTable="81c148af-5b40-40e2-8381-ba8537e445af";
srcCasLib="CASUSER(kelly.mae@student.umn.ac.id)";
tgtCasTable="EVERBANK_DATASET_00000051428";
tgtCasLib="CASUSER(kelly.mae@student.umn.ac.id)";
saveType="sashdat";
tgtCasTableLabel="00000051428 KellyMae";
replace=1;
saveToDisk=1;

exists = doesTableExist(tgtCasLib, tgtCasTable);
if (exists !=0) then do;
  if (replace == 0) then do;
    print "Table already exists and replace flag is set to false.";
    exit ({severity=2, reason=5, formatted="Table already exists and replace flag is set to false.", statusCode=9});
  end;
end;

if (saveToDisk == 1) then do;
  /* Save will automatically save as type represented by file ext */
  saveName=tgtCasTable;
  if(saveType != "") then do;
    saveName=tgtCasTable || "." || saveType;
  end;
  table.save result=r status=rc / caslib=tgtCasLib name=saveName replace=replace
    table={
      caslib=srcCasLib
      name=srcCasTable
    };
  if rc.statusCode != 0 then do;
    return rc.statusCode;
  end;
  tgtCasPath=dictionary(r, "name");

  dropTableIfExists(tgtCasLib, tgtCasTable);
  dropTableIfExists(tgtCasLib, tgtCasTable);

  table.loadtable result=r status=rc / caslib=tgtCasLib path=tgtCasPath casout={name=tgtCasTable caslib=tgtCasLib} promote=1;
  if rc.statusCode != 0 then do;
    return rc.statusCode;
  end;
end;

else do;
  dropTableIfExists(tgtCasLib, tgtCasTable);
  dropTableIfExists(tgtCasLib, tgtCasTable);
  table.promote result=r status=rc / caslib=srcCasLib name=srcCasTable target=tgtCasTable targetLib=tgtCasLib;
  if rc.statusCode != 0 then do;
    return rc.statusCode;
  end;
end;


dropTableIfExists("CASUSER(kelly.mae@student.umn.ac.id)", "81c148af-5b40-40e2-8381-ba8537e445af");

function doesTableExist(casLib, casTable);
  table.tableExists result=r status=rc / caslib=casLib table=casTable;
  tableExists = dictionary(r, "exists");
  return tableExists;
end func;

function dropTableIfExists(casLib,casTable);
  tableExists = doesTableExist(casLib, casTable);
  if tableExists != 0 then do;
    print "Dropping table: "||casLib||"."||casTable;
    table.dropTable result=r status=rc/ caslib=casLib table=casTable quiet=0;
    if rc.statusCode != 0 then do;
      exit();
    end;
  end;
end func;

/* Return list of columns in a table */
function columnList(casLib, casTable);
  table.columnInfo result=collist / table={caslib=casLib,name=casTable};
  ndimen=dim(collist['columninfo']);
  featurelist={};
  do i =  1 to ndimen;
    featurelist[i]=upcase(collist['columninfo'][i][1]);
  end;
  return featurelist;
end func;
