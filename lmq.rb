# coding: utf-8
# filename: lmq.rb

# if Sonic Pi and Open Sound Control reside on the same machine
# you can leave this as it is; otherwise fill in the hosts IP
# "Open Stage Control" can be started like this at the command line:
# $ open-stage-control --send 127.0.0.1:4559 --port 9000
set :ip, "127.0.0.1" # e. g. 192.168.2.114
set :port, 9000
# set 4 sample folder each containing at least 4 samples:
set :folders, ["~/path/to/sample/folder/00/",
               "~/path/to/sample/folder/01/",
               "~/path/to/sample/folder/02/",
               "~/path/to/sample/folder/03/"]

# for testing it will be okay to set up just one folder and
# repeat this line 4 times:
# set :folders, ["~/path/to/sample/folder/",
#                "~/path/to/sample/folder/",
#                "~/path/to/sample/folder/",
#                "~/path/to/sample/folder/"]

set :my_bpm, 90

# - you can leave everything after here ...
use_osc get(:ip), get(:port)
use_sched_ahead_time 1
set :num_grid_cols, 16
set :num_grid_rows, 4
use_bpm get(:my_bpm)
amp = [1, 1, 1, 1, 1, 1, 1, 1]
set :amp, amp
lpf = [130, 130, 130, 130, 130, 130, 130, 130]
set :lpf, lpf
hpf = [0, 0, 0, 0, 0, 0, 0, 0]
set :hpf, hpf
attack = [0, 0, 0, 0, 0, 0, 0, 0]
set :attack, attack
# split values: sustain for grid/release for looper
sus_rel = [1, 1, 1, 1, 0, 0, 0, 0]
set :sus_rel, sus_rel
rpitch = [0, 0, 0, 0, 0, 0, 0, 0]
set :rpitch, rpitch
pitch = [0, 0, 0, 0, 0, 0, 0, 0]
set :pitch, pitch
window_size = [0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001]
set :window_size, window_size
pitch_dis = [0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001]
set :pitch_dis, pitch_dis
time_dis = [0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001]
set :time_dis, time_dis
beat_stretch = [4, 4, 4, 4]
set :beat_stretch, beat_stretch
rate = [1, 1, 1, 1]
set :rate, rate
quant = [0.25, 0.25, 0.25, 0.25]
set :quant, quant

(0..8).each do | i |
  osc "/sample/amp/" + i.to_s, amp[i]
  osc "/sample/lpf/" + i.to_s, lpf[i]
  osc "/sample/hpf/" + i.to_s, hpf[i]
  osc "/sample/attack/" + i.to_s, attack[i]
  osc "/sample/sus_rel/" + i.to_s, sus_rel[i]
  osc "/sample/rpitch/" + i.to_s, rpitch[i]
  osc "/sample/pitch/" + i.to_s, 0
  osc "/sample/window_size/" + i.to_s, 0
  osc "/sample/pitch_dis/" + i.to_s, 0
  osc "/sample/time_dis/" + i.to_s, 0
  osc "/sample/beat_stretch/" + i.to_s, beat_stretch[i]
  osc "/sample/rate/" + i.to_s, rate[i]
  osc "/sample/quant/" + i.to_s, quant[i]
end

selector = [0, 0, 0, 0]
set :selector, selector
alt = [0, 0, 0, 0]
set :alt, alt
row_mode = ["sam", "sam", "sam", "sam"]
set :row_mode, row_mode

(0..3).each do | i |
  osc "/grid/row/selector/" + i.to_s, selector[i]
  osc "/grid/row/alt/" + i.to_s, alt[i]
  osc "/grid/row/mode/" + i.to_s, 0.0
end

firing = [false, false, false, false]
set :firing, firing

fresh_start = [false, false, false, false]
set :fresh_start, fresh_start

x_start = [0, 16, 32, 48, 64]
set :x_start, x_start

x_end = [15, 31, 47, 63]
set :x_end, x_end

grid_rows = [
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
  [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31],
  [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47],
  [48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63]
]
score = grid_rows
set :grid_rows, grid_rows
set :score, score

num_slices = [16, 16, 16, 16]
set :num_slices, num_slices

last_slice = [nil, nil, nil, nil]
set :last_slice, last_slice

# looper initialisation
set :default_len_track, 8 # default track length

set :monitor, true
set :time_fix_play, -0.025 # latency fix

set :rec_metro, get(:metro_amp) # recording metro volume
set :master_amp_rec, 2.0 # recording master volume
set :master_amp_play, 1.0 # playback master volume

set :sync_beatstep, 0

looper_len = [8, 8, 8, 8]
set :looper_len, looper_len
looper_play = [0, 0, 0, 0]
set :looper_play, looper_play
looper_rec = [0, 0, 0, 0]
set :looper_rec, looper_rec

set :metro_on, 0
set :metro_amp, 1

osc "/looper/metro/on", get(:metro_on)
osc "/looper/metro/amp", get(:metro_amp)

(0..3).each do | i |
  osc "/looper/len/" + i.to_s, get(:looper_len)[i]
  osc "/looper/rec/" + i.to_s, get(:looper_rec)[i]
  osc "/looper/play/" + i.to_s, get(:looper_play)[i]
end

# /looper initialisation

define :msg do | text, var=" " |
  puts "--------------------"
  puts "#{text} #{var}"
  puts "++++++++++++++++++++"
  puts "                    "
end

define :switch_row do |row_num, toggle|
  start = row_num * 16
  16.times do
    if toggle == 1
      osc "/grid/num/" + start.to_s, 1
    else
      osc "/grid/num/" + start.to_s, 0
    end
    start += 1
    puts start
  end
end

define :parse_osc do |address|
  v = get_event(address).to_s.split(",")[6]
  if v != nil
    return v[3..-2].split("/")
  else
    return ["error"]
  end
end

define :load_sample_for_mode do | mode, row |
  sample_free_all # don't know if that makes sense

  case mode
  when "sam"
    s = get(:path), row
    set ("sample_" + row.to_s), s
  when "rec"
    i = row # + 1 # FIXME: rename samples in looper so they start with 0
    s = "~/.sonic-pi/store/default/cached_samples/t" + i.to_s + ".wav"
    set ("sample_" + row.to_s), s
  when "tab"
    msg "tab mode, don't know what to do yet ..."
  end
end

# initial loading of sample in mode: sam
set :path, get(:folders)[0]
osc "/grid/folder", 0.0
(0..3).each do | i |
  load_sample_for_mode(get(:row_mode)[i], i)
end
sleep 2

live_loop :watch_folders do
  use_real_time
  f = "/osc/grid/folder"
  data  = sync f

  case data[0].to_i
  when 0
    set :path, get(:folders)[0]
  when 1
    set :path, get(:folders)[1]
  when 2
    set :path, get(:folders)[2]
  when 3
    set :path, get(:folders)[3]
  end
  # load all sample with new path
  (0..3).each do | i |
    load_sample_for_mode(get(:row_mode)[i], i)
  end
end

live_loop :watch_row_mode do
  # sam = 0.0, rec = 1.0, tab = 2.0
  use_real_time
  m  = "/osc/grid/row/mode/*"
  data  = sync m
  seg   = parse_osc m
  row   = seg[4].to_i
  case data[0].to_i
  when 0
    row_mode[row] = "sam"
  when 1
    row_mode[row] = "rec"
  when 2
    row_mode[row] = "tab"
  end

  set :row_mode, row_mode
  load_sample_for_mode(row_mode[row], row)
end

live_loop :watch_row_selector do
  use_real_time
  s  = "/osc/grid/row/selector/*"
  data  = sync s
  seg   = parse_osc s
  num   = seg[4].to_i

  if data[0] == 1
    selector[num] = 1
  elsif data[0] == 0
    selector[num] = 0
  end
  set :selector, selector

end

live_loop :watch_alt do
  use_real_time
  a     = "/osc/grid/row/alt/*"
  data  = sync a
  seg   = parse_osc a
  num = seg[4].to_i

  if data[0] == 1
    alt[num] = 1
    osc "/grid/row/alt/" + num.to_s, 1
  elsif data[0] == 0
    alt[num] = 0
    osc "/grid/row/alt/" + num.to_s, 0
  end
  set :alt, alt
end

live_loop :watch_amp do
  use_real_time
  a     = "/osc/grid/row/amp/*"
  data  = sync a
  seg   = parse_osc a
  num = seg[4].to_i
  amp[num] = data[0].round(2)
  control get(("s" + num.to_s).to_sym), amp: amp[num]
  set :amp, amp
end

live_loop :watch_sample_controls do
  use_real_time
  a     = "/osc/sample/*/*"
  data  = sync a
  seg   = parse_osc a
  num   = seg[3].to_i
  opt   = seg[2].to_sym

  # e. g. attack can't be handled with 'control'
  if opt.to_s == "amp" or opt.to_s == "lpf" or opt.to_s == "hpf"
    modulable = true
  else
    modulable = false
  end

  handle = ("s" + num.to_s).to_sym

  eval(opt.to_s)[num] = data[0]
  set opt, eval(opt.to_s)

  if modulable
    control get(handle), opt=>data[0]
  end

  # msg "Current opt: ", eval(opt.to_s)[num]
  # msg "Opt: ", opt

end

define :which_row do |button_number, row|
  if get(:grid_rows)[row].member?(button_number)
    return row
  else
    which_row(button_number, row + 1)
  end
end

live_loop :watch_grid_rows do
  use_real_time
  r     = "/osc/grid/num/*"
  data  = sync r
  seg   = parse_osc r
  num = seg[3].to_i
  osc "/grid/num/" + num.to_s, 1

  y = which_row(num, 0)

  if data[0] == 1 and get(:alt)[y] == 0
    x_start[y] = num
    firing[y] = true
  elsif data[0] == 0 and get(:alt)[y] == 0
    firing[y] = false
  end

  if data[0] == 1 and get(:alt)[y] == 1
    x_end[y] = num
    firing[y] = false
  end

  if x_start[y] == x_end[y]
    score[y] = (ring x_start[y])
  else
    score[y] = (range x_start[y], x_end[y], inclusive: true)
  end

  set :x_start, x_start
  set :x_end, x_end
  set :score, score
  set :firing, firing
  # msg "Score für aktuelle Reihe: ", score[y]

end

define :build_row_loop do |y|

  # fixme: Check if this is a good sync mechanism between Grid and Looper
  live_loop ("row_" + y.to_s).to_sym, sync: ("looper_record_" + y.to_s).to_sym do
    use_real_time
    if get(:selector)[y] == 1 and get(:row_mode) != "tab"
      # continiously pressing the button
      if get(:firing)[y]

        i = get(:x_start)[y]

        last_slice[y] = (get(:x_start)[y] % get(:num_grid_cols))
        set :last_slice, last_slice

        s = sample get(("sample_" + y.to_s).to_sym),
          amp: get(:amp)[y],
          lpf: get(:lpf)[y],
          hpf: get(:hpf)[y],
          attack: get(:attack)[y] / 2.0,
          sustain: get(:sus_rel)[y] / 4.0,
          rpitch: get(:rpitch)[y],
          pitch: get(:pitch)[y],
          window_size: get(:window_size)[y],
          pitch_dis: get(:pitch_dis)[y],
          time_dis: get(:time_dis)[y],
          beat_stretch: get(:beat_stretch)[y],
          rate: get(:rate)[y],
          num_slices: get(:num_slices)[y],
          slice: i
        set ("s" + y.to_s).to_sym, s
        osc "/grid/num/" + i.to_s, 1
        sleep get(:quant)[y] / 6.0 * 1
        osc "/grid/num/" + i.to_s, 0
        sleep get(:quant)[y] / 6.0 * 5

        # no button pressed
      elsif !get(:firing)[y]

        osc "/grid/num/" + get(:x_start)[y].to_s, 0

        if get(:last_slice)[y] != nil
          tick_set 1
          last_slice[y] = nil
          set :last_slice, last_slice
        end

        i = tick % get(:score)[y].size

        if get(:fresh_start)[y]
          tick_set 1
          current = get(:x_start)[y]
          fresh_start[y] = false
          set :fresh_start, fresh_start
        elsif
          current = get(:score)[y][i].to_i
        end

        s = sample get(("sample_" + y.to_s).to_sym),
          amp: get(:amp)[y],
          lpf: get(:lpf)[y],
          hpf: get(:hpf)[y],
          attack: get(:attack)[y] / 2.0,
          sustain: get(:sus_rel)[y] / 4.0,
          rpitch: get(:rpitch)[y],
          pitch: get(:pitch)[y],
          window_size: get(:window_size)[y],
          pitch_dis: get(:pitch_dis)[y],
          time_dis: get(:time_dis)[y],
          beat_stretch: get(:beat_stretch)[y],
          rate: get(:rate)[y],
          num_slices: get(:num_slices)[y],
          slice: current
        set ("s" + y.to_s).to_sym, s
        sleep get(:quant)[y] / 6.0 * 2
        osc "/grid/num/" + current.to_s, 1
        sleep get(:quant)[y] / 6.0 * 4
        osc "/grid/num/" + current.to_s, 0
      end
    else
      # nothing is playing so indicate that next time
      # loop starts again it should start from the beginning
      if fresh_start[y] != true
        fresh_start[y] = true
        set :fresh_start, fresh_start
      end
      sleep get(:quant)[y]
    end
  end # end live_loop
end

(0..3).each do |i|
  build_row_loop(i)
end

### Live Looper #################################################################################


live_loop :watch_looper_controls do
  use_real_time
  adr   = "/osc/looper/*/*"
  data  = sync adr
  seg   = parse_osc adr

  if seg[2] == "metro"
    ctrl = seg[2].to_s + "_" + seg[3].to_s
    set ctrl.to_sym, data[0]
  else
    num = seg[3].to_i
    # /osc/looper/rec/0
    ctrl = seg[1].to_s + "_" + seg[2].to_s
    eval(ctrl)[num] = data[0].to_i
    set ctrl.to_sym, eval(ctrl)
  end
end

live_loop :beat do
  s = sample :elec_tick, amp: get(:metro_amp) if get(:metro_on) == 1
  set :beat_metro, s # set pointer for control statement
  if get(:sync_beatstep) == 1
    midi_clock_beat
  end
  sleep 1
end

if get(:sync_beatstep) == 1
  midi_start
end

# Metronome                                                        #
live_loop :metro_marking_one do
  sync :rec
  s = sample :elec_tick, amp: get(:metro_amp), rate: 0.75 if get(:metro_on) == 1
  set :marker_metro, s
  sleep get(:default_len_track)
end

# (Re)Play and Record Functions
define :build_playback_loop do | i |
  track_sample = buffer["t" + i.to_s, get(:looper_len)[i]]
  # controls start with 4 because all sample opts are handled together
  i2 = i + 4
  ctrl = ("t" + i.to_s).to_sym
  live_loop ("looper_play" + i.to_s).to_sym do
    on get(:looper_rec)[i] do
      cue :rec
      cnt = tick % 2
      in_thread do
        if cnt < 1
          n = get(:looper_len)[i] / 2.0
          sleep n
          n.times do
            m = sample :elec_tick, rate: 1.5, amp: get(:metro_amp) if get(:metro_on) == 1
            set :mute_metro, m
            sleep 1
          end
        end
      end
    end #on :looper_rec[n]
    on get(:looper_play)[i] do
      time_warp get(:time_fix_play) do
        s = sample track_sample,
          amp: get(:amp)[i2],
          lpf: get(:lpf)[i2],
          hpf: get(:hpf)[i2],
          attack: get(:attack)[i2] * get(:looper_len)[i] / 2.0,
          release: get(:sus_rel)[i2] * get(:looper_len)[i] / 2.0,
          rpitch: get(:rpitch)[i2],
          pitch: get(:pitch)[i2],
          window_size: get(:window_size)[i2],
          pitch_dis: get(:pitch_dis)[i2],
          time_dis: get(:time_dis)[i2]
        set ctrl, s
      end # time_warp
    end
    sleep get(:looper_len)[i]
  end
end

define :build_recording_loop do |i| # 0..3
  track_sample = buffer["t" + i.to_s, get(:looper_len)[i]]
  audio = ("audio_" + i.to_s).to_sym
  live_loop ("looper_record_" + i.to_s).to_sym do
    if get(:looper_rec)[i] == 1
      sync :rec
      looper_rec[i] = 0
      set :looper_rec, looper_rec
      in_thread do
        t = get(:looper_len)[i]
        (2 * t).times do
          osc "/looper/rec/" + i.to_s, 1
          sleep 0.25
          osc "/looper/rec/" + i.to_s, 0
          sleep 0.25
        end
      end
      live_audio :mon, :stop
      with_fx :record, buffer: track_sample, pre_amp: get(:master_amp_rec) do
        live_audio audio, stereo: true
      end
      sleep get(:looper_len)[i]
      live_audio audio, :stop
      osc "/looper/rec/" + i.to_s, 0
    elsif
      if get(:monitor)
        live_audio :mon, stereo: true # switch monitor on
      end
      sleep get(:looper_len)[i]
    end
  end
end

(0..3).each do | i |
  build_playback_loop(i)
  build_recording_loop(i)
end
