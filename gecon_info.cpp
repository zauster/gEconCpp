/*****************************************************************************
 * This file is a part of gEcon.                                             *
 *                                                                           *
 * (c) Chancellery of the Prime Minister of the Republic of Poland 2012-2015 *
 * (c) Grzegorz Klima, Karol Podemski, Kaja Retkiewicz-Wijtiwiak 2015-2016   *
 * License terms can be found in the file 'LICENCE'                          *
 *                                                                           *
 * Author: Grzegorz Klima                                                    *
 *****************************************************************************/

/** \file gecon_info.cpp
 * \brief Basic information about gEcon version.
 */


#include <gecon_info.h>
#ifdef R_DLL
#include <R.h>
#include <Rcpp.h>
#endif /* R_DLL */


std::string
gecon_ver_str()
{
    return "1.0.2 (2016-12-05)";
}


std::string
gecon_bug_str()
{
    return "Grzegorz Klima <gklima@users.sourceforge.net>";
}


std::string
gecon_web_str()
{
    return "http://gecon.r-forge.r-project.org/";
}

std::string
gecon_copyrights()
{
    return "(c) Chancellery of the Prime Minister of the Republic of Poland 2012-2015\n\
(c) Grzegorz Klima, Karol Podemski, Kaja Retkiewicz-Wijtiwiak 2015-2016";
}



std::string
gecon_hello_str()
{
    return "This is gEcon version " + gecon_ver_str() + '\n'
           + gecon_web_str();
}


#ifdef R_DLL
RcppExport
SEXP
welcome_R()
{
    return Rcpp::wrap(gecon_hello_str());
}
#endif /* R_DLL */
















