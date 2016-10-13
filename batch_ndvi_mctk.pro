;+
;             Extract '1 km monthly NDVI' from MOD13A3 products
;              and georefernce resulting image by calling MCTK
;              
;       To run this procedure, please make sure that
;       1. MCTK is correctly installed (ie; mctk.sav and modis_products.scsv are 
;       added into your ENVI save_add folder. For details see the Installation 
;       section of MCTK User's Guide.
;       2. As ENVI API functions (e.g. ENVI_PROJ_CREATE()) are invoked in this 
;       procedure, type ENVI in the IDL Console or use ENVI Classic + IDL to open 
;       IDL before compile and run this procedure.
;
;                       Version: 1.0.0 (2016-10-12)
;
;                    Author: Jun Cai, Ph.D. Candidate
;          (Center for Earth System Science, Tsinghua University)
;               Contact Email: cai-j12@mails.tsinghua.edu.cn
;
;                    Copyright: belongs to Dr.Xu's Lab
;          (Center for Earth System Science, Tsinghua University)
; (College of Global Change and Earth System Science, Beijing Normal University)
;-
PRO BATCH_NDVI_MCTK
  COMPILE_OPT idl2
  ; First restore all the base save files.
  ENVI, /RESTORE_BASE_SAVE_FILES

  ; Initialize ENVI Classic
  ENVI, /RESTORE_BASE_SAVE_FILES

  modis_grid_file = 'C:\MCTK-NDVI\MOD13A3.A2000032.h08v05.006.2015138123531.hdf'

  ; The specified output location MUST end in the appropriate path
  ; separator for your OS
  output_location = 'C:\MCTK-NDVI\MOD13A3_out\'

  output_rootname = 'MOD13A3.A2000032.h08v05'

  grid_name = 'MOD_Grid_monthly_1km_VI'
  sd_names = ['1 km monthly NDVI']

  ; Output method schema is:
  ; 0 = Standard, 1 = Projected, 2 = Standard and Projected
  out_method = 1

  output_projection = ENVI_PROJ_CREATE(/geographic)

  ; Choosing nearest neighbor interpolation
  interpolation_method = 0

  convert_modis_data, in_file=modis_grid_file, $
    out_path=output_location, out_root=output_rootname, $
    gd_name=grid_name, sd_names=sd_names, $
    out_method=out_method, out_proj=output_projection, interp_method=interpolation_method, $
    r_fid_array=r_fid_array, r_fname_array=r_fname_array, msg=msg

  ; Exit ENVI Classic
  ENVI_BATCH_EXIT
END
