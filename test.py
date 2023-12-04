import matplotlib.pyplot as plt


plt.rc('font', size=18);
plt.rcParams['figure.constrained_layout.use'] = True


# traning model

Bitrate_548 = [1024,2048,3072]
PSNR_548  = [40.420029,	44.153141,	46.633797]

Bitrate_274 = [96,128,256,384,512,1024,2048]
PSNR_274  = [23.944043,	25.935925,	30.725911,	33.592562,	35.680367,	39.89646,	42.84069]

Bitrate_138 = [64,96,128,256,512]
PSNR_138  = [23.332954,	23.982193,	25.582044,	29.094962,	31.219284]

plt.plot(Bitrate_548,PSNR_548,'r',label='548p')
plt.plot(Bitrate_274,PSNR_274,'b',label='274p')
plt.plot(Bitrate_138,PSNR_138,'g',label='138p')

plt.xlabel('Bitrate /kbps')
plt.ylabel('PSNR /dB')
plt.legend()
plt.show()
