mkdir out;
dco_out = out.yout.get("dco_out").Values.Data;
audiowrite("out/dco_out.wav", dco_out, 48000);
dcf_out = out.yout.get("dcf_out").Values.Data;
audiowrite("out/dcf_out.wav", dcf_out, 48000);
dcf_out2 = out.yout.get("dcf_out2").Values.Data;
audiowrite("out/dcf_out2.wav", dcf_out2, 48000);
mix_out = out.yout.get("dca_out").Values.Data;
audiowrite("out/dca_out.wav", mix_out, 48000);
