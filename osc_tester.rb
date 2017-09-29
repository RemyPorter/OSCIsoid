use_osc "localhost", 4601

live_loop :ping do
  osc "/sin/rotion/rotionCenter",0.25,0.0
  sleep 1
end