local SendCooldown = false

RegisterCommand('mobilepay', function(source, args, raw)
    local target = tonumber(args[1])
    local amount = tonumber(args[2])

    if target and amount then
        sendMoneyToPlayer(source, target, amount)
    else
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'MobilePay',
            description = 'Brug: /mobilepay [Spiller ID] [Beløb]',
            type = 'error'
        })
    end
end, false)

sendMoneyToPlayer = function(source, target, amount)
    if SendCooldown then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'MobilePay',
            description = 'Du kan ikke sende penge så hurtigt.',
            type = 'error'
        })
        return
    end

    local xPlayer = ESX.GetPlayerFromId(source)
    local zPlayer = ESX.GetPlayerFromId(target)

    if xPlayer and zPlayer then
        if xPlayer.getAccount('bank').money >= amount then
            xPlayer.removeAccountMoney('bank', amount)
            zPlayer.addAccountMoney('bank', amount)

            exports["lb-phone"]:SendNotification(target, {
                title = "Mobilepay",
                content = 'Du modtog '..ESX.Math.GroupDigits(amount)..' DKK fra '..xPlayer.getName(),
                icon = "https://cdn.discordapp.com/attachments/1214505689062440960/1214565665537527828/22961759.png?ex=65f9936c&is=65e71e6c&hm=03c324039168ada868de3524ceb4cb76dfc4ceee37ea334f0c39591b7a2794c1&"
            })

            exports["lb-phone"]:SendNotification(source, {
                title = "Mobilepay",
                content = 'Du sendte '..ESX.Math.GroupDigits(amount)..' DKK til '..zPlayer.getName(),
                icon = "https://cdn.discordapp.com/attachments/1214505689062440960/1214565665537527828/22961759.png?ex=65f9936c&is=65e71e6c&hm=03c324039168ada868de3524ceb4cb76dfc4ceee37ea334f0c39591b7a2794c1&"
            })

            SendCooldown = true
            Wait(10000)
            SendCooldown = false
        else    
            exports["lb-phone"]:SendNotification(source, {
                title = "MobilePay",
                content = 'Du har ikke '..ESX.Math.GroupDigits(amount)..' DKK på din bankkonto',
                icon = "https://cdn.discordapp.com/attachments/1214505689062440960/1214565665537527828/22961759.png?ex=65f9936c&is=65e71e6c&hm=03c324039168ada868de3524ceb4cb76dfc4ceee37ea334f0c39591b7a2794c1&"
            })
        end
    end
end