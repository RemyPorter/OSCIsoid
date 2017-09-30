use_osc "localhost", 4601

live_loop :ping do
  osc "/sin/marchingX/marchingXWeight",rand(-1..1),0.0
  osc "/sin/marchingY/marchingYWeight",rand(-1..1),0.0
  osc "/sin/divX/divXWeight",rand(-1..1),0.0
  osc "/sin/divY/divYWeight",rand(-1..1),0.0
  osc "/sin/rotion/rotionWeight",rand(-1..1),0.0
  osc "/sin/rotion/rotionCenter",rand(-1..1),rand(-1..1)
  osc "/sin/checker/checkWeight",rand(-1..1),0.0
  sleep 4
end