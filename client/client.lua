Prefix = GetCurrentResourceName()

local id = GetPlayerServerId(PlayerId())
local test = PlayerPedId(id)
local playerName = GetPlayerName(PlayerId())
local ScoreFinal = 0
Ped = nil
local animationDict = 'mp_common'
local animationName = "givetake2_b"

if k.other == 'true' then
  otherD = false
elseif k.other == 'false' then
  otherD = true
end

function IsAmu_Vip(playerName)
  -- Vérifiez si le nom du joueur est dans la liste des administrateurs
  for _, admin in ipairs(k.gestion_vip) do
      if playerName == admin then
          return true
      end
  end
  return false
end  
if IsAmu_Vip(playerName) then
  vipD = false
else
  vipD = true
end

function IsAdminAmmunation(playerName)
  -- Vérifiez si le nom du joueur est dans la liste des administrateurs
  for _, admin in ipairs(k.gestion) do
      if playerName == admin then
          return true
      end
  end
  return false
end  
if IsAdminAmmunation(playerName) then
  gestionD = false
else
  gestionD = true
end


lib.registerContext({
  id = 'Ammunation',
  title = 'Ammunation',
  options = {
    {
    title = 'Armes à feu',
    icon = 'person-rifle',
    iconColor = '#FFFFE1',
    description = 'Tenir hors de porter des enfants !',
    menu = 'weapon',
    },
    {
      title = 'Armes de Mélée',
      icon = 'gun',
      iconColor = '#BD7C7C',
      description = 'Armes à bout portant.',
      menu = 'melee',
    },
    {
      title = 'Autre',
      icon = 'ellipsis-vertical',
      iconColor = '#E8FFE1',
      description = 'Acceder à d\'autres items.',
      disabled = otherD,
      menu = 'autre',
    },
    {
      title = ' ',
      progress = '100',
      colorScheme = '#E2E2FF',
    },
    {
      title = 'Amu VIP',
      icon = 'star',
      iconColor = '#FDE7FF',
      description = 'Réservé aux vip du Ammunation !',
      disabled = vipD,
      onSelect = function()
        lib.showContext('amu_vip')
      end,
    },
    {
      title = 'Gestion',
      icon = 'gear',
      iconColor = '#DCFFFE',
      description = 'Réservé aux administrateurs !',
      disabled = gestionD,
      onSelect = function()
        lib.showContext('gestion_Ammunation')
      end,
    },
}})

optionsArme = {}

for k,v in pairs(k.weapon) do
    table.insert(optionsArme, {
        title = v.label, 
        description = 'Nom de l\'arme : '..v.model,
        progress = math.floor((v.price / 4) + 0.5),
        colorScheme = '#E2E2FF',
        disabled = v.disabled,
        metadata = {
          {label = 'Prix ', value = ' '..v.price}
        },
        onSelect = function()
          local input = lib.inputDialog('Ammunation',{{type = 'number', label = 'Nombre d\'armes', description = 'Renseigne un nombre supérieure à 0.', icon = 'fa-solid fa-star'}, {type = 'checkbox', label = 'Accepter', required = true}}) 
          local nombre = input[1]
          if nombre >= 1 then
            model = v.model
            price = v.price * nombre
          else
            lib.notify({  
              title = 'Ammunation',
              icon = 'fa-solid fa-star',
              description = 'Renseigne un nombre supérieure à 0 !',
              position = 'top',
              duration = 5000,
              style = {
                backgroundColor = '#141517',
                color = '#FFFFFF',
                ['.description'] = {
                  color = '#909296'
                },
              },
              type = 'error',
            })
            model = nil
            price = nil
          end  
          if model ~= nil and price ~= nil then
            if DoesEntityExist(Ped) then
              -- Déplacer le ped vers une nouvelle position
              local destinationPoint = vector(21.44, -1104.37, 29.80)  
              TaskGoStraightToCoord(Ped, destinationPoint.x, destinationPoint.y, destinationPoint.z, 1.0, -1, 0.0, 0.0)
          
              -- Attendre que le ped atteigne la destination
              while not IsEntityAtCoord(Ped, destinationPoint.x, destinationPoint.y, destinationPoint.z, 0.5, 0.5, 0.5, false, true, 0) do
                Wait(500)
              end
          
              -- Jouer l'animation
              
              PlayPedAnimation(Ped, animationDict, animationName)
        
              -- Ramener le ped à sa position d'origine
              TaskGoStraightToCoord(Ped, 22.48, -1105.51, 28.78, 167.24, 1.0, -1, 0.0, 0.0)
          
              -- Attendre que le ped revienne à sa position d'origine
              while not IsEntityAtCoord(Ped, 22.48, -1105.51, 28.78, 167.24, 0.5, 0.5, 0.5, false, true, 0) do
                Wait(500)
              end
              PlayPedAnimation(Ped, animationDict, animationName)
        
            end
            TriggerServerEvent('spawn_bag', 'p_cs_clothes_box_s', vector3(22.28, -1106.18, 29.79))
            if lib.progressBar({
              duration = 9700,
              label = 'Examination',
              useWhileDead = false,
              canCancel = false,
              disable = {
                  car = true,
                  move = true,
                  sprint = true,
              },
              anim = {
                dict = 'mini@triathlon',
                clip = "rummage_bag",
              }
            }) then
            ClearPedTasksImmediately(PlayerPedId())
            TriggerServerEvent("weapon", model, price, nombre)
            end
          end
        end
    })
end

optionsMelee = {}

for k,v in pairs(k.weapon_melee) do
    table.insert(optionsMelee, {
        title = v.label, 
        description = 'Nom de l\'arme : '..v.model,
        progress = math.floor((v.price / 4) + 0.5),
        colorScheme = '#E2E2FF',
        disabled = v.disabled,
        metadata = {
          {label = 'Prix ', value = ' '..v.price}
        },
        onSelect = function()
          local input = lib.inputDialog('Ammunation',{{type = 'number', label = 'Nombre d\'armes', description = 'Renseigne un nombre supérieure à 0.', icon = 'fa-solid fa-star'}, {type = 'checkbox', label = 'Accepter', required = true}}) 
          local nombre = input[1]
          if nombre >= 1 then
            model = v.model
            price = v.price * nombre
          else
            lib.notify({  
              title = 'Ammunation',
              icon = 'fa-solid fa-star',
              description = 'Renseigne un nombre supérieure à 0 !',
              position = 'top',
              duration = 5000,
              style = {
                backgroundColor = '#141517',
                color = '#FFFFFF',
                ['.description'] = {
                  color = '#909296'
                },
              },
              type = 'error',
            })
            model = nil
            price = nil
          end  
          if model ~= nil and price ~= nil then
            if DoesEntityExist(Ped) then
              -- Déplacer le ped vers une nouvelle position
              local destinationTourner = vector(13.89, -1103.4, 29.78)
              TaskGoStraightToCoord(Ped, destinationTourner.x, destinationTourner.y, destinationTourner.z, 1.0, -1, 0.0, 0.0)

              while not IsEntityAtCoord(Ped, destinationTourner.x, destinationTourner.y, destinationTourner.z, 0.5, 0.5, 0.5, false, true, 0) do
                Wait(100)
              end

              local destinationPoint = vector(4.29, -1105.05, 29.78)  
              TaskGoStraightToCoord(Ped, destinationPoint.x, destinationPoint.y, destinationPoint.z, 1.0, -1, 0.0, 0.0)
          
              -- Attendre que le ped atteigne la destination
              while not IsEntityAtCoord(Ped, destinationPoint.x, destinationPoint.y, destinationPoint.z, 0.5, 0.5, 0.5, false, true, 0) do
                Wait(500)
              end
          
              -- Jouer l'animation
              
              PlayPedAnimation(Ped, animationDict, animationName)
        
              -- Ramener le ped à sa position d'origine
              TaskGoStraightToCoord(Ped, 22.48, -1105.51, 28.78, 167.24, 1.0, -1, 0.0, 0.0)
          
              -- Attendre que le ped revienne à sa position d'origine
              while not IsEntityAtCoord(Ped, 22.48, -1105.51, 28.78, 167.24, 0.5, 0.5, 0.5, false, true, 0) do
                Wait(500)
              end
              PlayPedAnimation(Ped, animationDict, animationName)
        
            end
            TriggerServerEvent('spawn_bag', 'p_cs_clothes_box_s', vector3(22.28, -1106.18, 29.79))
            if lib.progressBar({
              duration = 9700,
              label = 'Examination',
              useWhileDead = false,
              canCancel = false,
              disable = {
                  car = true,
              },
              anim = {
                dict = 'mini@triathlon',
                clip = "rummage_bag",
              }
            }) then
            ClearPedTasksImmediately(PlayerPedId())
            TriggerServerEvent("weapon", model, price, nombre)
            end
          end
        end
    })
end

optionsAutre = {}

for k,v in pairs(k.weapon_other) do
    table.insert(optionsAutre, {
        title = v.label, 
        description = 'Nom de l\'arme : '..v.model,
        progress = math.floor((v.price / 4) + 0.5),
        colorScheme = '#E2E2FF',
        disabled = v.disabled,
        metadata = {
          {label = 'Prix ', value = ' '..v.price}
        },
        onSelect = function()
          local input = lib.inputDialog('Ammunation',{{type = 'number', label = 'Nombre d\'armes', description = 'Renseigne un nombre supérieure à 0.', icon = 'fa-solid fa-star'}, {type = 'checkbox', label = 'Accepter', required = true}}) 
          local nombre = input[1]
          if nombre >= 1 then
            model = v.model
            price = v.price * nombre
          else
            lib.notify({  
              title = 'Ammunation',
              icon = 'fa-solid fa-star',
              description = 'Renseigne un nombre supérieure à 0 !',
              position = 'top',
              duration = 5000,
              style = {
                backgroundColor = '#141517',
                color = '#FFFFFF',
                ['.description'] = {
                  color = '#909296'
                },
              },
              type = 'error',
            })
            model = nil
            price = nil
          end  
          if model ~= nil and price ~= nil then
            if DoesEntityExist(Ped) then
              -- Déplacer le ped vers une nouvelle position
              local destinationTourner = vector(18.80, -1104.39, 29.78)
              TaskGoStraightToCoord(Ped, destinationTourner.x, destinationTourner.y, destinationTourner.z, 1.0, -1, 0.0, 0.0)

              while not IsEntityAtCoord(Ped, destinationTourner.x, destinationTourner.y, destinationTourner.z, 0.5, 0.5, 0.5, false, true, 0) do
                Wait(100)
              end

              local destinationPoint = vector(19.59, -1109.93, 29.78)  
              TaskGoStraightToCoord(Ped, destinationPoint.x, destinationPoint.y, destinationPoint.z, 1.0, -1, 0.0, 0.0)
          
              -- Attendre que le ped atteigne la destination
              while not IsEntityAtCoord(Ped, destinationPoint.x, destinationPoint.y, destinationPoint.z, 0.5, 0.5, 0.5, false, true, 0) do
                Wait(500)
              end
          
              -- Jouer l'animation
              
              PlayPedAnimation(Ped, animationDict, animationName)
              
              TaskGoStraightToCoord(Ped, 18.96, -1104.07, 29.78, 1.0, -1, 0.0, 0.0)

              while not IsEntityAtCoord(Ped, 18.96, -1104.07, 29.78, 0.5, 0.5, 0.5, false, true, 0) do
                Wait(200)
              end
              -- Ramener le ped à sa position d'origine
              TaskGoStraightToCoord(Ped, 22.48, -1105.51, 28.78, 167.24, 1.0, -1, 0.0, 0.0)
          
              -- Attendre que le ped revienne à sa position d'origine
              while not IsEntityAtCoord(Ped, 22.48, -1105.51, 28.78, 167.24, 0.5, 0.5, 0.5, false, true, 0) do
                Wait(500)
              end
              PlayPedAnimation(Ped, animationDict, animationName)
        
            end
            TriggerServerEvent('spawn_bag', 'p_cs_clothes_box_s', vector3(22.28, -1106.18, 29.79))
            if lib.progressBar({
              duration = 9700,
              label = 'Examination',
              useWhileDead = false,
              canCancel = false,
              disable = {
                  car = true,
              },
              anim = {
                dict = 'mini@triathlon',
                clip = "rummage_bag",
              }
            }) then
            ClearPedTasksImmediately(PlayerPedId())
            TriggerServerEvent("weapon", model, price, nombre)
            end
          end
        end
    })
end

optionsArmeVip = {}

for k,v in pairs(k.weapon_vip) do
    table.insert(optionsArmeVip, {
        title = v.label, 
        description = 'Nom de l\'arme : '..v.model,
        progress = math.floor((v.price / 4) + 0.5),
        colorScheme = '#E2E2FF',
        metadata = {
          {label = 'Prix ', value = ' '..v.price}
        },
        onSelect = function()
          local input = lib.inputDialog('Ammunation',{{type = 'number', label = 'Nombre d\'armes', description = 'Renseigne un nombre supérieure à 0.', icon = 'fa-solid fa-star'}, {type = 'checkbox', label = 'Accepter', required = true}}) 
          local nombre = input[1]
          if nombre >= 1 then
            model = v.model
            price = v.price * nombre
          else
            lib.notify({  
              title = 'Ammunation',
              icon = 'fa-solid fa-star',
              description = 'Renseigne un nombre supérieure à 0 !',
              position = 'top',
              duration = 5000,
              style = {
                backgroundColor = '#141517',
                color = '#FFFFFF',
                ['.description'] = {
                  color = '#909296'
                },
              },
              type = 'error',
            })
            model = nil
            price = nil
          end  
          if model ~= nil and price ~= nil then
            if DoesEntityExist(Ped) then
              -- Déplacer le ped vers une nouvelle position
              local destinationPoint = vector(21.44, -1104.37, 29.80)  
              TaskGoStraightToCoord(Ped, destinationPoint.x, destinationPoint.y, destinationPoint.z, 1.0, -1, 0.0, 0.0)
          
              -- Attendre que le ped atteigne la destination
              while not IsEntityAtCoord(Ped, destinationPoint.x, destinationPoint.y, destinationPoint.z, 0.5, 0.5, 0.5, false, true, 0) do
                Wait(500)
              end
          
              -- Jouer l'animation
              
              PlayPedAnimation(Ped, animationDict, animationName)
        
              -- Ramener le ped à sa position d'origine
              TaskGoStraightToCoord(Ped, 22.48, -1105.51, 28.78, 167.24, 1.0, -1, 0.0, 0.0)
          
              -- Attendre que le ped revienne à sa position d'origine
              while not IsEntityAtCoord(Ped, 22.48, -1105.51, 28.78, 167.24, 0.5, 0.5, 0.5, false, true, 0) do
                Wait(500)
              end
              PlayPedAnimation(Ped, animationDict, animationName)
        
            end
            TriggerServerEvent('spawn_bag', 'p_cs_clothes_box_s', vector3(22.28, -1106.18, 29.79))
            if lib.progressBar({
              duration = 9700,
              label = 'Examination',
              useWhileDead = false,
              canCancel = false,
              disable = {
                  car = true,
                  move = true,
                  sprint = true,
              },
              anim = {
                dict = 'mini@triathlon',
                clip = "rummage_bag",
              }
            }) then
            ClearPedTasksImmediately(PlayerPedId())
            TriggerServerEvent("weapon", model, price, nombre)
            end
          end
        end
    })
end

lib.registerContext({
  menu = 'Ammunation',
  id = 'weapon',
  title = 'Armes à feu',
  options = optionsArme
})
lib.registerContext({
  menu = 'Ammunation',
  id = 'melee',
  title = 'Armes de Mélée',
  options = optionsMelee
})
lib.registerContext({
  menu = 'Ammunation',
  id = 'autre',
  title = 'Autre',
  options = optionsAutre
})
lib.registerContext({
  id = 'amu_vip',
  title = 'Armes du vip',
  options = optionsArmeVip
})
lib.registerContext({
  id = 'gestion_Ammunation',
  title = 'Gestion',
  options = {
    {
      title = 'Donner PPA',
      icon = 'people-arrows',
      iconColor = '#EDFFE8',
      description = 'Donne un ppa au joueur de ton choix.',
      onSelect = function()
        local input = lib.inputDialog('Give PPA',{{type = 'number', label = 'Destinataire', description = 'Id du joueur.', icon = 'star', required = true}, {type = 'checkbox', label = 'Accepter', required = true}})
        local target = input[1]
        TriggerServerEvent('giveppa', target)
      end,
    },
    {
      title = ' ',
      progress = '100',
    },
    {
      title = 'Carte membre+',
      icon = 'hand-holding-hand',
      iconColor = '#F7E1FF',
      description = 'Donne ou supprime des cartes membre+',
      onSelect = function()
        local input = lib.inputDialog('Carte Membre+',{{type = 'number', label = 'Joueur', description = 'Entre l\'Id du joueur.', icon = 'star', required = true}, {type = 'number', label = 'Nombres', description = 'Combien veux-tu en donner ou supprimer ?', required = true}, {type = 'checkbox', label = 'Donner'}, {type = 'checkbox', label = 'Supprimer'}})
        local target = input[1]
        local nombre = input[2]
        local donner = input[3]
        local sup = input[4]
        if donner and not sup then
          TriggerServerEvent('gestion_givecard', target, nombre)
        elseif sup and not donner then
          TriggerServerEvent('gestion_supcard', target, nombre)
        elseif donner and sup then
          lib.notify({  
            title = 'Ammunation',
            icon = 'fa-solid fa-star',
            description = 'Vous devez séléctionner qu\'une option !',
            position = 'top',
            duration = 5000,
            icon = 'star',
            style = {
              backgroundColor = '#141517',
              color = '#FFFFFF',
              ['.description'] = {
                color = '#909296'
              },
            },
            type = 'error'
          })
        end
      end,
    },
  }
})

RegisterNetEvent('Ammunation')
AddEventHandler('Ammunation', function()
  lib.showContext('Ammunation')
end)

RegisterNetEvent('Tire')
AddEventHandler('Tire', function()
  TriggerServerEvent('spawn_bag', 'v_ind_rc_workbag', vector3(13.74, -1096.78, 29.47))
  lib.progressCircle({
    duration = 5000, 
    label = 'Sort un Pistolet',
    useWhileDead = false,
    canCancel = false,
    disable = {
        car = true,
        move = true,
    },
    anim = {
      dict = 'mini@triathlon',
      clip = "rummage_bag",
    }
  })
  TriggerServerEvent('stand_add', 'weapon_pistol')

  Wait(7500)

  lib.notify({  
    title = '3',
    position = 'top',
    duration = 1000,
    style = {
      backgroundColor = '#141517',
      color = '#FFFFFF',
      ['.description'] = {
        color = '#909296'
      },
    },
  })

  Wait(1000)

  lib.notify({  
    title = '2',
    position = 'top',
    duration = 1000,
    style = {
      backgroundColor = '#141517',
      color = '#FFFFFF',
      ['.description'] = {
        color = '#909296'
      },
    },
  })

  Wait(1000)

  lib.notify({  
    title = '1',
    position = 'top',
    duration = 1000,
    style = {
      backgroundColor = '#141517',
      color = '#FFFFFF',
      ['.description'] = {
        color = '#909296'
      },
    },
  })

  Wait(1000)

  local hashtirun = GetHashKey("a_f_y_beach_01")
  while not HasModelLoaded(hashtirun) do
      RequestModel(hashtirun)
      Wait(20)
  end
  pedtesttirun = CreatePed("PED_TYPE_CIVFEMALE", "a_f_y_beach_01", k.pos.pedtirppa[4].positionUn.x, k.pos.pedtirppa[4].positionUn.y, k.pos.pedtirppa[4].positionUn.z, k.pos.pedtirppa[4].positionUn.h, false, true)
  SetBlockingOfNonTemporaryEvents(pedtesttirun, true)
  FreezeEntityPosition(pedtesttirun, true)
  TaskStartScenarioInPlace(pedtesttirun, 'WORLD_HUMAN_AA_COFFEE', 0, false)

  Wait(3500)
  
  if IsEntityDead(pedtesttirun) then
      DeleteEntity(pedtesttirun)
      ScoreFinal = ScoreFinal + 1
  else
      DeleteEntity(pedtesttirun)
  end

  local hashtirdeux = GetHashKey("hc_gunman")
  while not HasModelLoaded(hashtirdeux) do
      RequestModel(hashtirdeux)
      Wait(20)
  end
  pedtesttirdeux = CreatePed("PED_TYPE_CIVFEMALE", "hc_gunman", k.pos.pedtirppa[4].positionDeux.x, k.pos.pedtirppa[4].positionDeux.y, k.pos.pedtirppa[4].positionDeux.z, k.pos.pedtirppa[4].positionDeux.h, false, true)
  SetBlockingOfNonTemporaryEvents(pedtesttirdeux, true)
  FreezeEntityPosition(pedtesttirdeux, true)
  TaskStartScenarioInPlace(pedtesttirdeux, 'WORLD_HUMAN_DRUG_DEALER_HARD', 0, false)

  Wait(2300)

  if IsEntityDead(pedtesttirdeux) then
      DeleteEntity(pedtesttirdeux)
      ScoreFinal = ScoreFinal + 1
  else
      DeleteEntity(pedtesttirdeux)
  end

  local hashtirtrois = GetHashKey("hc_gunman")
  while not HasModelLoaded(hashtirtrois) do
      RequestModel(hashtirtrois)
      Wait(20)
  end
  pedtesttirtrois = CreatePed("PED_TYPE_CIVFEMALE", "hc_gunman", k.pos.pedtirppa[4].positionTrois.x, k.pos.pedtirppa[4].positionTrois.y, k.pos.pedtirppa[4].positionTrois.z, k.pos.pedtirppa[4].positionTrois.h, false, true)
  SetBlockingOfNonTemporaryEvents(pedtesttirtrois, true)
  FreezeEntityPosition(pedtesttirtrois, true)
  TaskStartScenarioInPlace(pedtesttirtrois, 'WORLD_HUMAN_DRUG_DEALER_HARD', 0, false)
  --GiveWeaponToPed(pedtesttirtrois, 0x9D61E50F --[[hash de l'arme : https://wiki.rage.mp/index.php?title=Weapons]], 0, true --[[arme en main]], true --[[arme en main]]) --donne une arme au ped

  Wait(2100)

  if IsEntityDead(pedtesttirtrois) then
      DeleteEntity(pedtesttirtrois)
      ScoreFinal = ScoreFinal + 1
  else
      DeleteEntity(pedtesttirtrois)
  end


  local hashtirquatre = GetHashKey("s_m_m_snowcop_01")
  while not HasModelLoaded(hashtirquatre) do
      RequestModel(hashtirquatre)
      Wait(20)
  end
  pedtesttirquatre = CreatePed("PED_TYPE_CIVFEMALE", "s_m_m_snowcop_01", k.pos.pedtirppa[4].positionQuatre.x, k.pos.pedtirppa[4].positionQuatre.y, k.pos.pedtirppa[4].positionQuatre.z, k.pos.pedtirppa[4].positionQuatre.h, false, true)
  SetBlockingOfNonTemporaryEvents(pedtesttirquatre, true)
  FreezeEntityPosition(pedtesttirquatre, true)
  TaskStartScenarioInPlace(pedtesttirquatre, 'WORLD_HUMAN_STAND_FIRE', 0, false)

  Wait(2000)

  if IsEntityDead(pedtesttirquatre) then
      DeleteEntity(pedtesttirquatre)
      ScoreFinal = ScoreFinal + 1
  else
      DeleteEntity(pedtesttirquatre)
  end

  if lib.skillCheck({'easy', 'easy', {areaSize = 60, speedMultiplier = 1.5}, 'easy'}, {'z', 'q', 's', 'd'}) then
    ScoreFinal = ScoreFinal + 1
    lib.notify({  
      title = 'Stand',
      description = 'Je vais augmenter la difficultée !',
      position = 'top',
      duration = 5000,
      style = {
        backgroundColor = '#141517',
        color = '#FFFFFF',
        ['.description'] = {
          color = '#909296'
        },
      },
      type = 'success',
    })
  else
    lib.notify({  
      title = 'Stand',
      description = 'Dommage... essaye encore',
      position = 'top',
      duration = 5000,
      style = {
        backgroundColor = '#141517',
        color = '#FFFFFF',
        ['.description'] = {
          color = '#909296'
        },
      },
      type = 'error',
    })
  end

  Wait(200)

  local hashtircinq = GetHashKey("hc_gunman")
  while not HasModelLoaded(hashtircinq) do
      RequestModel(hashtircinq)
      Wait(20)
  end
  pedtesttircinq = CreatePed("PED_TYPE_CIVFEMALE", "hc_gunman", k.pos.pedtirppa[4].positionCinq.x, k.pos.pedtirppa[4].positionCinq.y, k.pos.pedtirppa[4].positionCinq.z, k.pos.pedtirppa[4].positionCinq.h, false, true)
  SetBlockingOfNonTemporaryEvents(pedtesttircinq, true)
  FreezeEntityPosition(pedtesttircinq, true)
  TaskStartScenarioInPlace(pedtesttircinq, 'WORLD_HUMAN_DRUG_DEALER_HARD', 0, false)
  --GiveWeaponToPed(pedtesttircinq, 0x9D61E50F --[[hash de l'arme : https://wiki.rage.mp/index.php?title=Weapons]], 0, true --[[arme en main]], true --[[arme en main]]) --donne une arme au ped

  Wait(1700)

  if IsEntityDead(pedtesttircinq) then
      DeleteEntity(pedtesttircinq)
      ScoreFinal = ScoreFinal + 1
  else
      DeleteEntity(pedtesttircinq)
  end


  local hashtirsix = GetHashKey("a_f_y_clubcust_04")
  while not HasModelLoaded(hashtirsix) do
      RequestModel(hashtirsix)
      Wait(20)
  end
  pedtesttirsix = CreatePed("PED_TYPE_CIVFEMALE", "a_f_y_clubcust_04", k.pos.pedtirppa[4].positionSix.x, k.pos.pedtirppa[4].positionSix.y, k.pos.pedtirppa[4].positionSix.z, k.pos.pedtirppa[4].positionSix.h, false, true)
  SetBlockingOfNonTemporaryEvents(pedtesttirsix, true)
  FreezeEntityPosition(pedtesttirsix, true)
  TaskStartScenarioInPlace(pedtesttirsix, 'WORLD_HUMAN_AA_SMOKE', 0, false)

  Wait(1500)

  if IsEntityDead(pedtesttirsix) then
      DeleteEntity(pedtesttirsix)
      ScoreFinal = ScoreFinal + 1
  else
      DeleteEntity(pedtesttirsix)
  end


  local hashtirsept = GetHashKey("mp_m_securoguard_01")
  while not HasModelLoaded(hashtirsept) do
      RequestModel(hashtirsept)
      Wait(20)
  end
  pedtesttirsept = CreatePed("PED_TYPE_CIVFEMALE", "mp_m_securoguard_01", k.pos.pedtirppa[4].positionUn.x, k.pos.pedtirppa[4].positionUn.y, k.pos.pedtirppa[4].positionUn.z, k.pos.pedtirppa[4].positionUn.h, false, true)
  SetBlockingOfNonTemporaryEvents(pedtesttirsept, true)
  FreezeEntityPosition(pedtesttirsept, true)
  TaskStartScenarioInPlace(pedtesttirsept, 'WORLD_HUMAN_CLIPBOARD', 0, false)

  Wait(2100)

  if IsEntityDead(pedtesttirsept) then
      DeleteEntity(pedtesttirsept)
      ScoreFinal = ScoreFinal + 1
  else
      DeleteEntity(pedtesttirsept)
  end

  if lib.skillCheck({'easy', 'medium', {areaSize = 60, speedMultiplier = 1.0}, 'easy'}, {'z', 'r', 'a', 'm'}) then
    ScoreFinal = ScoreFinal + 1
    lib.notify({  
      title = 'Stand',
      description = 'Bien joué !',
      position = 'top',
      duration = 5000,
      style = {
        backgroundColor = '#141517',
        color = '#FFFFFF',
        ['.description'] = {
          color = '#909296'
        },
      },
      type = 'success',
    })
  else
    lib.notify({  
      title = 'Stand',
      description = 'Dommage... essaye encore',
      position = 'top',
      duration = 5000,
      style = {
        backgroundColor = '#141517',
        color = '#FFFFFF',
        ['.description'] = {
          color = '#909296'
        },
      },
      type = 'error',
    })
  end

  Wait(200)

  local hashtirhuit = GetHashKey("mp_m_bogdangoon")
  while not HasModelLoaded(hashtirhuit) do
      RequestModel(hashtirhuit)
      Wait(20)
  end
  pedtesttirhuit = CreatePed("PED_TYPE_CIVFEMALE", "mp_m_bogdangoon", k.pos.pedtirppa[4].positionDeux.x, k.pos.pedtirppa[4].positionDeux.y, k.pos.pedtirppa[4].positionDeux.z, k.pos.pedtirppa[4].positionDeux.h, false, true)
  SetBlockingOfNonTemporaryEvents(pedtesttirhuit, true)
  FreezeEntityPosition(pedtesttirhuit, true)
  TaskStartScenarioInPlace(pedtesttirhuit, 'WORLD_HUMAN_DRUG_DEALER_HARD', 0, false)
  --GiveWeaponToPed(pedtesttirhuit, 0x9D61E50F --[[hash de l'arme : https://wiki.rage.mp/index.php?title=Weapons]], 0, true --[[arme en main]], true --[[arme en main]]) --donne une arme au ped

  Wait(2000)

  if IsEntityDead(pedtesttirhuit) then
      DeleteEntity(pedtesttirhuit)
      ScoreFinal = ScoreFinal + 1
  else
      DeleteEntity(pedtesttirhuit)
  end


  local hashtirneuf = GetHashKey("hc_gunman")
  while not HasModelLoaded(hashtirneuf) do
      RequestModel(hashtirneuf)
      Wait(20)
  end
  pedtesttirneuf = CreatePed("PED_TYPE_CIVFEMALE", "hc_gunman", k.pos.pedtirppa[4].positionTrois.x, k.pos.pedtirppa[4].positionTrois.y, k.pos.pedtirppa[4].positionTrois.z, k.pos.pedtirppa[4].positionTrois.h, false, true)
  SetBlockingOfNonTemporaryEvents(pedtesttirneuf, true)
  FreezeEntityPosition(pedtesttirneuf, true)
  TaskStartScenarioInPlace(pedtesttirneuf, 'WORLD_HUMAN_DRUG_DEALER_HARD', 0, false)
  --GiveWeaponToPed(pedtesttirneuf, 0x9D61E50F --[[hash de l'arme : https://wiki.rage.mp/index.php?title=Weapons]], 0, true --[[arme en main]], true --[[arme en main]]) --donne une arme au ped

  Wait(2300)

  if IsEntityDead(pedtesttirneuf) then
      DeleteEntity(pedtesttirneuf)
      ScoreFinal = ScoreFinal + 1
  else
      DeleteEntity(pedtesttirneuf)
  end

  local hashtirdix = GetHashKey("s_m_m_snowcop_01")
  while not HasModelLoaded(hashtirdix) do
      RequestModel(hashtirdix)
      Wait(20)
  end
  pedtesttirdix = CreatePed("PED_TYPE_CIVFEMALE", "s_m_m_snowcop_01", k.pos.pedtirppa[4].positionQuatre.x, k.pos.pedtirppa[4].positionQuatre.y, k.pos.pedtirppa[4].positionQuatre.z, k.pos.pedtirppa[4].positionQuatre.h, false, true)
  SetBlockingOfNonTemporaryEvents(pedtesttirdix, true)
  FreezeEntityPosition(pedtesttirdix, true)
  TaskStartScenarioInPlace(pedtesttirdix, 'WORLD_HUMAN_STAND_FIRE', 0, false)

  Wait(1700)

  if IsEntityDead(pedtesttirdix) then
      DeleteEntity(pedtesttirdix)
      ScoreFinal = ScoreFinal + 1
  else
      DeleteEntity(pedtesttirdix)
  end

  local hashtironze = GetHashKey("a_f_y_beach_01")
  while not HasModelLoaded(hashtironze) do
      RequestModel(hashtironze)
      Wait(20)
  end
  pedtesttironze = CreatePed("PED_TYPE_CIVFEMALE", "a_f_y_beach_01", k.pos.pedtirppa[4].positionCinq.x, k.pos.pedtirppa[4].positionCinq.y, k.pos.pedtirppa[4].positionCinq.z, k.pos.pedtirppa[4].positionCinq.h, false, true)
  SetBlockingOfNonTemporaryEvents(pedtesttironze, true)
  FreezeEntityPosition(pedtesttironze, true)
  TaskStartScenarioInPlace(pedtesttironze, 'WORLD_HUMAN_AA_COFFEE', 0, false)

  Wait(2000)
  
  if IsEntityDead(pedtesttironze) then
      DeleteEntity(pedtesttironze)
      ScoreFinal = ScoreFinal + 1
  else
      DeleteEntity(pedtesttironze)
  end


  local hashtirdouze = GetHashKey("a_f_y_clubcust_04")
  while not HasModelLoaded(hashtirdouze) do
      RequestModel(hashtirdouze)
      Wait(20)
  end
  pedtesttirdouze = CreatePed("PED_TYPE_CIVFEMALE", "a_f_y_clubcust_04", k.pos.pedtirppa[4].positionSix.x, k.pos.pedtirppa[4].positionSix.y, k.pos.pedtirppa[4].positionSix.z, k.pos.pedtirppa[4].positionSix.h, false, true)
  SetBlockingOfNonTemporaryEvents(pedtesttirdouze, true)
  FreezeEntityPosition(pedtesttirdouze, true)
  TaskStartScenarioInPlace(pedtesttirdouze, 'WORLD_HUMAN_AA_SMOKE', 0, false)

  Wait(1500)

  if IsEntityDead(pedtesttirdouze) then
      DeleteEntity(pedtesttirdouze)
      ScoreFinal = ScoreFinal + 1
  else
      DeleteEntity(pedtesttirdouze)
  end

  if lib.skillCheck({'easy', 'medium', {areaSize = 60, speedMultiplier = 1.0}, 'medium'}, {'i', 'g', 'n', 'w'}) then
    ScoreFinal = ScoreFinal + 1
    lib.notify({  
      title = 'Stand',
      description = 'Bravo à toi !',
      position = 'top',
      duration = 5000,
      style = {
        backgroundColor = '#141517',
        color = '#FFFFFF',
        ['.description'] = {
          color = '#909296'
        },
      },
      type = 'success',
    })
  else
    lib.notify({  
      title = 'Stand',
      description = 'Dommage... tu y était presque !',
      position = 'top',
      duration = 5000,
      style = {
        backgroundColor = '#141517',
        color = '#FFFFFF',
        ['.description'] = {
          color = '#909296'
        },
      },
      type = 'error',
    })
  end

  Wait(100)

  TriggerServerEvent('stand_remove', 'weapon_pistol')
  if ScoreFinal >= 10 then
    TriggerServerEvent('standppayes')
    lib.notify({  
      title = 'Stand',
      description = 'Ton score est de : '..ScoreFinal..' points',
      position = 'top',
      duration = 5000,
      style = {
        backgroundColor = '#141517',
        color = '#FFFFFF',
        ['.description'] = {
          color = '#909296'
        },
      },
    })
    Wait(1500)
    lib.notify({  
      title = 'Stand',
      icon = 'fa-solid fa-star',
      description = 'Vous avez réussi le test !',
      position = 'top',
      duration = 5000,
      style = {
        backgroundColor = '#141517',
        color = '#FFFFFF',
        ['.description'] = {
          color = '#909296'
        },
      },
      type = 'success'
    })
  else
    lib.notify({  
      title = 'Stand',
      description = 'Ton score est de : '..ScoreFinal..' points',
      position = 'top',
      duration = 5000,
      style = {
        backgroundColor = '#141517',
        color = '#FFFFFF',
        ['.description'] = {
          color = '#909296'
        },
      },
    })
    Wait(1500)
    lib.notify({  
      title = 'Stand',
      icon = 'fa-solid fa-star',
      description = 'Votre score est inférieur à 7 !',
      position = 'top',
      duration = 5000,
      style = {
        backgroundColor = '#141517',
        color = '#FFFFFF',
        ['.description'] = {
          color = '#909296'
        },
      },
      type = 'error'
    })
  end 

  ScoreFinal = 0

end)

RegisterNetEvent('Stand')
AddEventHandler('Stand', function()
  CreateThread( function()
    Wait(500)
      if checkItem('card_member') then
        TriggerServerEvent('getppa', k.ppa)
      else 
        lib.notify({  
          title = 'Ammunation',
          icon = 'fa-solid fa-star',
          description = 'Vous n\'avez pas la carte Membre+',
          position = 'top',
          duration = 5000,
          style = {
            backgroundColor = '#141517',
            color = '#FFFFFF',
            ['.description'] = {
              color = '#909296'
            },
          },
          type = 'error'
        })
      end   
  end)
  function checkItem(item)
    local hasItem = ESX.SearchInventory(item, 1)
    if hasItem >= 1 then
      return true
    else
      return false
    end
  end
end)

Citizen.CreateThread(function()
  local blip = AddBlipForCoord(k.amunation.x, k.amunation.y, k.amunation.z)
  BeginTextCommandSetBlipName('STRING')
  EndTextCommandSetBlipName(blip)
end)

if k.ped == 'boy' then
  CreateThread(function()
    local hash = GetHashKey('a_m_m_business_01')
    local animationDict = 'mp_common'
    local animationName = "givetake2_b"
    lib.requestModel(hash)
    Ped = CreatePed("boy", 'a_m_m_business_01', k.amunation.x, k.amunation.y, k.amunation.z, k.amunation.h, true)
    SetEntityInvincible(ped, true)
    TaskPlayAnim(ped, lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_SMOKING", 0, true) 
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
  end)
  CreateThread(function()
    local hash = GetHashKey('ig_nigel')
    lib.requestModel(hash)
    local ped = CreatePed("boy", 'ig_nigel', 12.00, -1106.94, 28.78, 340.15, true)
    TaskPlayAnim(ped, lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true) 
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
  end)
elseif k.ped == 'girl' then
  CreateThread(function()
    local hash = GetHashKey('g_f_y_vagos_01')
    lib.requestModel(hash)
    Ped = CreatePed("girl", 'g_f_y_vagos_01', k.amunation.x, k.amunation.y, k.amunation.z, k.amunation.h, true)
    TaskPlayAnim(ped, lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_SMOKING", 0, true) 
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
  end)
  CreateThread(function()
    local hash = GetHashKey('g_f_y_families_01')
    lib.requestModel(hash)
    local ped = CreatePed("girl", 'g_f_y_families_01', 12.00, -1106.94, 28.78, 340.15, true)
    TaskPlayAnim(ped, lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_SMOKING", 0, true) 
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
  end)
end

if k.systemAmunation == 'automatic' then
Citizen.CreateThread(function()
  while true do 
      local playerPed = PlayerPedId()
      local playerCoords = GetEntityCoords(playerPed)
      local distance = GetDistanceBetweenCoords(k.amunation.x, k.amunation.y, k.amunation.z + 1, playerCoords.x, playerCoords.y, playerCoords.z, false)
      ZZ = 1000
          if distance < 1.7 then
          ZZ = 0
          lib.showTextUI('Ammunation { E } ', {
              id = 'test',
              icon = 'fa-solid fa-star',
              iconColor = '#E2E2FF',
              position = 'top-center',
              style = {
                  borderRadius = 6,
                  backgroundColor = '#141517',
                  color = '#FFFFFF',
                  ['.description'] = {
                    color = '#909296'
                  },
              }
          })
          if IsControlJustPressed(0, 46) then
            lib.showContext('Ammunation')
          end
      else
          ZZ = 1000
          lib.hideTextUI()
      end
      Citizen.Wait(ZZ)
  end
end)
elseif k.systemAmunation == 'target' then
  exports.ox_target:addBoxZone({
    coords =  vec3(k.amunation.x, k.amunation.y, k.amunation.z + 1),
    size = vec3(1, 1, 1),
    rotation = 45,
    debug = drawZones,
    options = {
        {
          name = 'box',
          icon = "fa-solid fa-star",
          blip = { id = 566, colour = 31, scale = 0.8 },
          label = "Ammunation",
          onSelect = function()
            TriggerEvent('Ammunation')
          end
        }
        }
      }
  )
end

if k.systemStand == 'automatic' then
  Citizen.CreateThread(function()
    while true do 
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local distance = GetDistanceBetweenCoords(13.66, -1097.16, 29.81 + 1, playerCoords.x, playerCoords.y, playerCoords.z, false)
        ZZ = 1000
            if distance < 1.5 then
            ZZ = 0
            lib.showTextUI('Stand { E } ', {
                id = 'stand',
                icon = 'fa-solid fa-star',
                iconColor = '#E2E2FF',
                position = 'top-center',
                style = {
                    borderRadius = 6,
                    backgroundColor = '#141517',
                    color = '#FFFFFF',
                    ['.description'] = {
                      color = '#909296'
                    },
                }
            })
            if IsControlJustPressed(0, 46) then
              TriggerEvent('Stand')
            end
        else
            ZZ = 1000
            lib.hideTextUI()
        end
        Citizen.Wait(ZZ)
    end
  end)
elseif k.systemStand == 'target' then
  exports.ox_target:addBoxZone({
    coords =  vec3(13.80, -1096.81, 30.47),
    size = vec3(1, 1, 1),
    rotation = 45,
    debug = drawZones,
    options = {
        {
          name = 'box',
          icon = "fa-solid fa-star",
          label = "Stand",
          onSelect = function()
            TriggerEvent('Stand')
          end
        }
        }
      }
  )
  exports.ox_target:addBoxZone({
    coords =  vec3(12.00, -1106.94, 29.78),
    size = vec3(1, 1, 1),
    rotation = 45,
    debug = drawZones,
    options = {
        {
          name = 'box',
          icon = "fa-solid fa-id-card-clip",
          label = "Carte Membre+",
          onSelect = function()
            lib.progressBar({
              duration = '1000',
              label = 'Emprunt',
              useWhileDead = false,
              canCancel = false,
              disable = {
                  car = true,
                  move = true,
              },
              anim = {
                  dict = 'anim@amb@prop_human_atm@interior@male@enter',
                  clip = 'enter'
              },
            })
            TriggerServerEvent('card_member', 'card_member', k.card)
          end
        },
        }
      }
  )
end

RegisterNetEvent('ppa')
AddEventHandler('ppa', function()
  TriggerServerEvent('buyppa', k.ppa)
end)

Citizen.CreateThread(function()
  while true do 
      local playerPed = PlayerPedId()
      local playerCoords = GetEntityCoords(playerPed)
      local distance = GetDistanceBetweenCoords(12.00, -1106.94, 29.78 + 1, playerCoords.x, playerCoords.y, playerCoords.z, false)
      ZZ = 1000
          if distance < 2.0 then
          ZZ = 0
          lib.showTextUI('Prix : '..k.card..'$', {
              id = 'stand',
              icon = 'fa-solid fa-shop',
              iconColor = '#E2E2FF',
              position = 'top-center',
              style = {
                  borderRadius = 6,
                  backgroundColor = '#141517',
                  color = '#FFFFFF',
                  ['.description'] = {
                    color = '#909296'
                  },
              }
          })
      else
          ZZ = 1000
          lib.hideTextUI()
      end
      Citizen.Wait(ZZ)
  end
end)

function PlayPedAnimation(Ped, animationDict, animationName)
  RequestAnimDict(animationDict)
  
  while not HasAnimDictLoaded(animationDict) do
      Wait(500)
  end

  TaskPlayAnim(Ped, animationDict, animationName, 8.0, -8.0, -1, 1, 0, false, false, false)

  local animationDuration = GetAnimDuration(animationDict, animationName)
  Wait(math.floor(animationDuration * 1000))
  
  ClearPedTasks(Ped)
end