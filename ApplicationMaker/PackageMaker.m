(* ::Package:: *)

(************************************************************************)
(* This file was generated automatically by the Mathematica front end.  *)
(* It contains Initialization cells from a Notebook file, which         *)
(* typically will have the same name as this file except ending in      *)
(* ".nb" instead of ".m".                                               *)
(*                                                                      *)
(* This file is intended to be loaded into the Mathematica kernel using *)
(* the package loading commands Get or Needs.  Doing so is equivalent   *)
(* to using the Evaluate Initialization Cells menu command in the front *)
(* end.                                                                 *)
(*                                                                      *)
(* DO NOT EDIT THIS FILE.  This entire file is regenerated              *)
(* automatically each time the parent Notebook file is saved in the     *)
(* Mathematica front end.  Any changes you make to this file will be    *)
(* overwritten.                                                         *)
(************************************************************************)



(* :Title: PackageMaker *) 
(* :Author: jmlopez *)
(* :Email: jmlopez.rod@gmail.com *)
(* :Summary: Provides functions to create a new package inside an application
			 and to update the application init file. *)
(* :Context: ApplicationMaker`PackageMaker` *)
(* :Package version: 1.0 *)
(* :History:  Version 1.0 July 10 2011 *)
(* :Mathematica version: 8.0 for Mac OS X x86 (64-bit) (February 23, 2011) *)
(* :Discussion: The function NewPackage creates a new notebook to help you 
				write functions for the package. The function UpdateInit
				updates the application init file. *)


BeginPackage["ApplicationMaker`PackageMaker`"];


Unprotect[NewPackage, UpdateInit];
ClearAll[NewPackage, UpdateInit];


(* :Usage Messages: *)


NewPackage::usage = 
"NewPackage[\!\(\*
StyleBox[\"pkgName\", \"TI\"]\), \!\(\*
StyleBox[\"appName\", \"TI\"]\)] creates the notebook \!\(\*
StyleBox[\"pkgName\", \"TI\"]\)\!\(\*
StyleBox[\".\", \"TI\"]\)\!\(\*
StyleBox[\"nb\", \"TI\"]\) and its respective \!\(\*
StyleBox[\"m\", \"TI\"]\) file inside the application \!\(\*
StyleBox[\"appName\", \"TI\"]\).";
UpdateInit::usage =
"UpdateInit[\!\(\*
StyleBox[\"appName\", \"TI\"]\)] creates the init file for the application \!\(\*
StyleBox[\"appName\", \"TI\"]\).";


(* :Error Messages: *)


NewPackage::argerr=
"Strings specifying the package name and the application it belongs to were expected.";
NewPackage::nodir =
"There is no application `1` in `2`. To create a new application use NewApplication";
NewPackage::pkgerr = 
"The package you are trying to create in the application `1` already exists. Click `2` to edit its contents.";
UpdateInit::nodir =
"There is no application `1` in `2`. To create a new application use NewApplication";


Begin["`Private`"];


NewPackage[args___] := (Message[NewPackage::argerr];$Failed)
NewPackage[pkgName_String, appName_String,
appDir_String: FileNameJoin[{ $UserBaseDirectory,"Applications"}]
] := Module[
{appNameDir, pkgPath, nb},
appNameDir =  FileNameJoin[{appDir, appName}];
If[!DirectoryQ[appNameDir], Message[NewPackage::nodir, appName, appDir]; Return[$Failed]];
pkgPath = FileNameJoin[{appNameDir,pkgName<>".nb" }];
If[FileExistsQ[pkgPath],
Message[NewPackage::pkgerr, appName, Hyperlink["here", pkgPath]]; 
Return[$Failed]
];
nb = CreateDocument[];
SetOptions[nb, 
TaggingRules-> None,
AutoGeneratedPackage-> Automatic,
StyleDefinitions-> Notebook[
{
Cell[StyleData[StyleDefinitions-> "Default.nb"]],
Cell[StyleData["Input"], InitializationCell-> True]
},
Visible-> False,
StyleDefinitions-> "PrivateStylesheetFormatting.nb"
]
];
NotebookWrite[nb, Cell["(* :Title: "<>pkgName<>" *) 
(* :Author: "<>$UserName<>" *)
(* :Summary: Summary goes here. *)
(* :Context: "<>appName<>"`"<>pkgName<>"` *)
(* :Package version: 1.0 *)
(* :History:  Version 1.0 "<>DateString[{"MonthName", " ", "Day", " " , "Year"}]<>" *)
(* :Mathematica version: "<>$Version<>" *)
(* :Discussion: Give more details here.*)" // StandardForm, "Code"]];
NotebookWrite[nb, Cell["BeginPackage[\""<>appName<>"`"<>pkgName<>"`\"];" // StandardForm, "Code"]];
NotebookWrite[nb, Cell["(* :Code Section (Call Unprotect and ClearAll): *)" // StandardForm, "Input"]];
NotebookWrite[nb, Cell["(* :Usage Messages: *)" // StandardForm, "Code"]];
NotebookWrite[nb, Cell["(* :Code Section: *)" // StandardForm, "Input"]];
NotebookWrite[nb, Cell["(* :Error Messages: *)" // StandardForm, "Code"]];
NotebookWrite[nb, Cell["(* :Code Section: *)" // StandardForm, "Input"]];
NotebookWrite[nb, Cell["Begin[\"`Private`\"];" // StandardForm, "Code"]];
NotebookWrite[nb, Cell["(* :Code Section: *)" // StandardForm, "Input"]];
NotebookWrite[nb, Cell["End[];" // StandardForm, "Code"]];
NotebookWrite[nb, Cell["(* :Code Section (Call Protect): *)" // StandardForm, "Input"]];
NotebookWrite[nb, Cell["EndPackage[];" // StandardForm, "Code"]];
NotebookSave[nb, pkgPath];
Return[nb];
]


UpdateInit[
appName_String, 
appDir_String:FileNameJoin[{ $UserBaseDirectory,"Applications"}]
]:= Module[
{appNameDir, pkgName, nb},
appNameDir =  FileNameJoin[{appDir, appName}];
If[!DirectoryQ[appNameDir], Message[UpdateInit::nodir, appName, appDir]; Return[$Failed]];
pkgName = Map[FileBaseName, FileNames@FileNameJoin[{appNameDir, "*.nb"}]];
nb = OpenWrite[FileNameJoin[{appNameDir, "Kernel", "Init.m"}]];
Do[
WriteString[nb, "Get[\""<>appName<>"`"<>pkgName[[i]]<>"`\"];\n"];
,{i, Length@pkgName}];
Close[nb]
]


End[];


Protect[NewPackage, UpdateInit];


EndPackage[];