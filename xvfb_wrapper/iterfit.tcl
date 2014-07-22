# Call rmsdtt
::rmsdtt::rmsdtt

# Set selection
$::rmsdtt::w.top.left.sel delete 1.0 end
$::rmsdtt::w.top.left.sel insert end "protein"

# Add all molecules
::rmsdtt::mol_add

# Iterative fitting options
#   - number of iterations
set ::rmsdtt::ifit_niter 3
#   - weights transform function: linear, exp, expmin, minmax, gaussian
set ::rmsdtt::ifit_type  expmin
#   - weights transform function factor
set ::rmsdtt::ifit_factor 1.0
#   - save results to file
set ::rmsdtt::ifit_save 1
set ::rmsdtt::ifit_file "ifit_results.dat"
#   - do not plot (do not modify)
set ::rmsdtt::ifit_plot 0
#   - do not update (do not modify)
set ::rmsdtt::ifit_update 0

# Do iterative fitting
::rmsdtt::iterativeFit

# Exit
quit
