function Hbe = heatExchangeCoefBEFcn(Global, Cgas_b, Cgas_e, Tb, Te, ub, db)
% -------------------------------------------------------------------------
  % heatExchangeCoefBE function 
  % ----------------------------| input |----------------------------------
  %  Global = constant values structure   
  %  Cgas_b = concentration vector of each species (bubble)       [mol/cm3]
  %  Cgas_e = concentration vector of each species (emulsion)     [mol/cm3]
  %      Tb = bubble temperature                                        [K]
  %      Te = emulsion temperature                                      [K]
  %      ub = bubble velocity                                        [cm/s]
  %      db = bubble diameter                                          [cm]
  % -----
  %     umf = minimum fluidization velocity                          [cm/s]   
  %       g = gravity                                               [cm/s2]
  %     Emf = minimum fluidization porosity                              []
  %      Cg = gas mixing concentration  (bubble/emulsion)         [mol/cm3]   
  %     Cpg = gas mixing heat capacity  (bubble/emulsion)         [J/mol K] 
  %      kg = thermal conductivity of the mixing gas       
  %                                   (bubble/emulsion)            [W/cm k]
  %     Hbc = heat exchange coefficient between bubble-cloud      [W/K cm3]
  %     Hce = heat exchange coefficient between cloud-emulsion    [W/K cm3]
  % ----------------------------| output |---------------------------------
  %     Hbe = heat exchange coefficient between bubble-emulsion [J/s cm3 K] 
% -------------------------------------------------------------------------
    umf   = Global.umf;
    g     = Global.g;
    Emf   = Global.Emf;
    Cg_b  = cGasMixFcn(Cgas_b);
    Cg_e  = cGasMixFcn(Cgas_e);
    Cpg_b = cpGasMixFcn(Global, Cgas_b, Tb);
    Cpg_e = cpGasMixFcn(Global, Cgas_e, Te);

    kg_b  = thermalCondMixGasFcn(Global, Tb, Cgas_b);
    kg_e  = thermalCondMixGasFcn(Global, Te, Cgas_e);

    temporal_1 = 4.5.*(umf.*Cg_b.*Cpg_b)./db;
    temporal_2 = (5.85.*(g.^(1/4)))./(db.^(5/4));
    temporal_3 = (kg_b.*Cg_b.*Cpg_b).^(1/2);

    Hbc = temporal_1 + temporal_2.*temporal_3;

    temporal_4 = 6.78.*((Cg_e.*Cpg_e.*kg_e).^(1/2));
    temporal_5 = (Emf.*ub./(db.^3)).^(1/2);

    Hce = temporal_4.*temporal_5;

    Hbe = ((1./Hbc) + (1./Hce)).^(-1);

% -------------------------------------------------------------------------
end