clear all
close all
clc

load('Processed_Data.mat')
id = input('enter ID: ');

Zvector_Mimosa_left = Database(id).Zvector_Mimosa_left;
Zvector_Mimosa_right = Database(id).Zvector_Mimosa_right;
Zvector_Titan_left = Database(id).Zvector_Titan_left;
Zvector_Titan_right = Database(id).Zvector_Titan_right;
Zvector_ER10x_left = Database(id).Zvector_ER10x_left;
Zvector_ER10x_right = Database(id).Zvector_ER10x_right;

fax=([100 10000]);
fay_Absorb=[0 1.1];
fay_Zang=[-.3 .3];
fay_Zmag=[1e6 1e9];
    
     
figure(1)
orient tall 
            subplot(321)
            semilogx(Zvector_Mimosa_left(:,1),Zvector_Mimosa_left(:,2),'b')
            hold on
            semilogx(Zvector_Titan_left(:,1),Zvector_Titan_left(:,2),'color', [252/255,146/255,114/255])
            hold on
            semilogx(Zvector_ER10x_left(:,1),Zvector_ER10x_left(:,2),'k')
            xlim(fax)
            ylim(fay_Absorb)
            ylabel('Absorbance')
            title('Left Ear')
            
            subplot(323)
            loglog(Zvector_Mimosa_left(:,1),Zvector_Mimosa_left(:,3),'b')
            hold on
            loglog(Zvector_Titan_left(:,1),Zvector_Titan_left(:,3),'color', [252/255,146/255,114/255])
            hold on
            loglog(Zvector_ER10x_left(:,1),Zvector_ER10x_left(:,3),'k')
            xlim(fax)
            ylim(fay_Zmag)
            ylabel('Z mag (mks Ohms)')
            
            subplot(325)
            semilogx(Zvector_Mimosa_left(:,1),Zvector_Mimosa_left(:,4),'b')
            hold on
            semilogx(Zvector_Titan_left(:,1),Zvector_Titan_left(:,4),'color', [252/255,146/255,114/255])
            hold on
            semilogx(Zvector_ER10x_left(:,1),Zvector_ER10x_left(:,4),'k')
            xlim(fax)
            ylim(fay_Zang)
            xlabel('Frequency (Hz)')
            ylabel('Z angle (cycles)')
            legend('Mimosa L', 'Titan L','ER10x L','Location','NorthWest')
        
            %right ear
            subplot(322)
            semilogx(Zvector_Mimosa_right(:,1),Zvector_Mimosa_right(:,2),'r')
            hold on
            semilogx(Zvector_Titan_right(:,1),Zvector_Titan_right(:,2),'m')
            hold on
            semilogx(Zvector_ER10x_right(:,1),Zvector_ER10x_right(:,2),'color',[49/255,163/255,84/255])
            xlim(fax)
            ylim(fay_Absorb)
            ylabel('Absorbance')
            title('Right Ear')
            
            subplot(324)
            loglog(Zvector_Mimosa_right(:,1),Zvector_Mimosa_right(:,3),'r')
            hold on
            loglog(Zvector_Titan_right(:,1),Zvector_Titan_right(:,3),'m')
            hold on
            loglog(Zvector_ER10x_right(:,1),Zvector_ER10x_right(:,3),'color',[49/255,163/255,84/255])
            xlim(fax)
            ylabel('Z mag (mks ohms)')
            ylim(fay_Zmag)
             
            subplot(326)
            semilogx(Zvector_Mimosa_right(:,1),Zvector_Mimosa_right(:,4),'r')
            hold on
            semilogx(Zvector_Titan_right(:,1),Zvector_Titan_right(:,4),'m')
            hold on
            semilogx(Zvector_ER10x_right(:,1),Zvector_ER10x_right(:,4),'color',[49/255,163/255,84/255])
            xlim(fax)
            ylim(fay_Zang)
            xlabel('Frequency (Hz)')
            ylabel('Z angle (cycles)')
            legend('Mimosa R', 'Titan R','ER10x R','Location','NorthWest')
