# Audio jack configuration
dev=/sys/devices/platform/msm_ssbi.0/pm8058-core/simple_remote_pf/simple_remote
echo 0,201 > $dev/accessory_min_vals
echo 200,1599 > $dev/accessory_max_vals
echo 0,100,280,500 > $dev/button_min_vals
echo 99,199,399,699 > $dev/button_max_vals
echo 512 > $dev/btn_trig_period_freq  # Button Period Freq(Hz)
echo 16 > $dev/btn_trig_period_time   # Button Period Time(Cycle)
echo 512 > $dev/btn_trig_hyst_freq    # Button Hysteresis Freq(Hz)
echo 16 > $dev/btn_trig_hyst_time     # Button Hysteresis Time(Cycle)
echo 400 > $dev/btn_trig_level

# Proximity sensor configuration
dev=/sys/bus/i2c/devices/3-0054/
val_cycle=2
val_nburst=7
val_freq=3
val_threshold=15
val_filter=0

nv_param_loader 60240 prox_cal
val_calibrated=$?
case $val_calibrated in
 1)
  nv_param_loader 60240 threshold
  val_threshold=$?
  nv_param_loader 60240 rfilter
  val_filter=$?
  ;;
esac

echo $val_cycle > $dev/cycle    # Duration Cycle. Valid range is 0 - 3.
echo $val_nburst > $dev/nburst  # Number of pulses in burst. Valid range is 0 - 15.
echo $val_freq > $dev/freq      # Burst frequency. Valid range is 0 - 3.
echo $val_threshold > $dev/threshold # sensor threshold. Valid range is 0 - 15 (0.12V - 0.87V)
echo $val_filter > $dev/filter  # RFilter. Valid range is 0 - 3.

# LMU AS3676 Configuration
dev=/sys/class/leds
echo 3000 > $dev/button-backlight/max_current

# TI BQ275xx firmware loader
bq275xx_fwloader
