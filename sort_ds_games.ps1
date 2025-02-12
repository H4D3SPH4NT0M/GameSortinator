# Define categories based on game franchises or developers
$categories = @{
    "Pokémon"                        = "Pokemon"
    "Wario"                          = "Wario"
    "Mario"                          = "Mario"
    "Zelda"                          = "Zelda"
    "Metroid"                        = "Metroid"
    "Kirby"                          = "Kirby"
    "Donkey Kong"                    = "DonkeyKong"
    "Final Fantasy"                  = "FinalFantasy"
    "Sonic"                          = "Sonic"
    "Mega Man"                       = "MegaMan"
    "Battle Network"                 = "MegaMan"
    "MegaMan Battle Network"         = "MegaMan"
    "MegaMan ZX"                     = "MegaMan"
    "MegaMan Legends"                = "MegaMan"
    "Castlevania"                    = "Castlevania"
    "Dragon Quest"                   = "DragonQuest"
    "Bomberman"                      = "Bomberman"
    "Rayman"                         = "Rayman"
    "Pac-Man"                        = "PacMan"
    "Harvest Moon"                   = "HarvestMoon"
    "Resident Evil"                  = "ResidentEvil"
    "Yu-Gi-Oh"                       = "YuGiOh"
    "Naruto"                         = "Naruto"
    "One Piece"                      = "OnePiece"
    "Dragon Ball"                    = "DragonBall"
    "Medal of Honor"                 = "MedalOfHonor"
    "Call of Duty"                   = "CallOfDuty"
    "Need for Speed"                 = "NeedForSpeed"
    "Star Wars"                      = "StarWars"
    "Spider-Man"                     = "SpiderMan"
    "Batman"                         = "Batman"
    "Transformers"                   = "Transformers"
    "Indiana Jones"                  = "IndianaJones"
    "GTA"                            = "GrandTheftAuto"
    "Lego"                           = "Lego"
    "Tetris"                         = "Tetris"
    "Professor Layton"               = "ProfessorLayton"
    "Cooking Mama"                   = "CookingMama"
    "Brain Age"                      = "BrainAge"
    "Imagine"                        = "ImagineSeries"
    "Catz"                           = "Catz"
    "Dogz"                           = "Dogz"
    "Nintendogs"                     = "Nintendogs"
    "Sims"                           = "TheSims"
    "Animal Crossing"                = "AnimalCrossing"
    "Yoshi"                          = "Yoshi"
    "Contra"                         = "Contra"
    "FIFA"                           = "FIFA"
    "Madden"                         = "MaddenNFL"
    "Tony Hawk"                      = "TonyHawk"
    "Tiger Woods"                    = "TigerWoods"
    "Puyo Puyo"                      = "PuyoPuyo"
    "Ace Attorney"                   = "AceAttorney"
    "Advance Wars"                   = "AdvanceWars"
    "Elite Beat Agents"              = "EliteBeatAgents"
    "The Legend of Kage"             = "TheLegendofKage"
    "Kingdom Hearts"                 = "KingdomHearts"
    "Pokémon Ranger"                 = "PokemonRanger"
    "Fire Emblem"                    = "FireEmblem"
    "Touch! Generations"             = "TouchGenerations"
    "Phoenix Wright"                 = "PhoenixWright"
    "Luxor"                          = "Luxor"
    "Ninja Gaiden"                   = "NinjaGaiden"
    "Yu-Gi-Oh! GX"                   = "YuGiOhGX"
    "Castlevania: Order of Ecclesia" = "CastlevaniaOrderOfEcclesia"
    "Final Fantasy Tactics"          = "FinalFantasyTactics"
    "Super Scribblenauts"            = "Scribblenauts"
    "Monster Hunter"                 = "MonsterHunter"
    "Zelda: Phantom Hourglass"       = "ZeldaPhantomHourglass"
    "Metroid Prime Hunters"          = "MetroidPrimeHunters"
    "The World Ends With You"        = "TheWorldEndsWithYou"
    "Super Mario 64 DS"              = "SuperMario64DS"
    "Mario Kart DS"                  = "MarioKartDS"
    "Mario Party DS"                 = "MarioPartyDS"
    "Mario Tennis"                   = "MarioTennis"
}

# Create an "Unsorted" folder for unknown games
$unsortedFolder = "Unsorted"
if (!(Test-Path $unsortedFolder)) { 
    New-Item -ItemType Directory -Path $unsortedFolder 
}

# Get all .nds files in the current directory
Get-ChildItem *.nds | ForEach-Object {
    $fileName = $_.Name
    $moved = $false

    # Check if the file matches any franchise keyword
    foreach ($keyword in $categories.Keys) {
        # Update matching to check if the keyword is anywhere in the file name (case-insensitive)
        if ($fileName -match [regex]::Escape($keyword) -or $fileName -match "(?i)MegaMan") {
            $folder = $categories[$keyword]
            if (!(Test-Path $folder)) { 
                New-Item -ItemType Directory -Path $folder 
            }
            Move-Item $_.FullName -Destination $folder
            $moved = $true
            break
        }
    }

    # If the game doesn't match any known category, move it to "Unsorted"
    if (-not $moved) {
        Move-Item $_.FullName -Destination $unsortedFolder
    }
}
