var bar

const app = new Vue({
    el: '#app',
    data: {
        playerId: 0,
        cash: 0,
        joblabel: '',
        grade_label: '',

        svg: [],
        currentHud: 'classic',
        selectSpeedUnit: 'kmh',
        selectedMap: 'radial',
        showCompass: true,
        hide: false,
        indicatorDegree: 0,
        enableCinematic: false,
        speed: 0,
        rpm: 0,
        fuel: 0,
        settingsOpen: false,
        showSpeedometer: false,
        speedometerSize: 1.1,
        showHideBox: true,
        hideBoxData : {
            health: 100,
            armor : 100,
            water : 100,
            stress : 100,
            hunger : 100,
            stamina: 100,
        },
        hideBoxDataDisplay: {
            health: 100,
            armor: 100,
            water: 100,
            stress: 100,
            hunger: 100,
            stamina: 100,
        },
        heading: '',
        statusData: {
            health: 0,
            hunger: 0,
            thirst: 0,
            stamina: 0,
            stress: 0,
            armour: 0,
            altitude: 0,
            nitro: 0,
            mic_level: 1,
            talking: false,
        },
        bars: {
            bar_1: null,
            bar_2: null,
            bar_3: null,
            bar_4: null,
            bar_5: null,
            bar_6: null,
            bar_7: false,

            bar_1_set: false,
            bar_2_set: false,
            bar_3_set: false,
            bar_4_set: false,
            bar_5_set: false,
            bar_6_set: false,
            bar_7_set: false,
        },
        text1: '',
        text2: '',
        addedMoney: null,
        isMinus: false,
        street: '',
        zone: '',
        clock: '',
        date: '',
        forceHide: true,
        DisplayRealTime: true,
        displayOnWalk: false,
        useStress: true,
        cruiseIsOn: false,
        engineIsOn: false,
        sealtBeltIsOn: false,
        lightsOn: false,
        locales: {},
        showParachute: false,
        showAltitude: false,
        altitude: 0,
        enableWaterMarkHud: true,
        useNitro: true,
        moneyType: 'cash',
        dateDisplay: true,
        seatbeltDisplayActive: false,
        cruiseDisplayActive: false,
        resourceName: 'Test',
        UseWaterMarkText: true,
        WaterMarkLogo: '',
        text1Style: {},
        text2Style: {},
        logoWidth: 0,
        logoHeight: 0,
        enableAmmoHud: true,
        displayAmmoHud: false,
        ammo: 0,
        max_ammo: 0,
        refreshRate: 0,
        enableHunger: true,
        enableThirst: true,
        enableStamina: true,
        enableArmor: true,
        enableHealth: true,
        positionsData: {}, 
        displayRefreshRate : 0,
        editModeActive : false,
        enableHud : false,
        enableSpeedometer : true,
    },

    watch:{
        refreshRate(newD, old){
            if (newD <= 135){
                $.post(`https://${this.resourceName}/hudselected`, JSON.stringify({ settingstype: 'refreshRate', val: 135 }));
            }
        },
        hideBoxData: {
            handler(val) {
                // do stuff
                if (val.stamina >100){
                    $.post(`https://${this.resourceName}/hudselected`, JSON.stringify({
                        settingstype: "hideBoxData", val: {
                            ...this.hideBoxData,
                            ["stamina"]: 100
                        }
                    }));
                }
                if (val.health > 100) {
                    $.post(`https://${this.resourceName}/hudselected`, JSON.stringify({
                        settingstype: "hideBoxData", val: {
                            ...this.hideBoxData,
                            ["health"]: 100
                        }
                    }));
                }
                if (val.stress > 100) {
                    $.post(`https://${this.resourceName}/hudselected`, JSON.stringify({
                        settingstype: "hideBoxData", val: {
                            ...this.hideBoxData,
                            ["stress"]: 100
                        }
                    }));
                }
                if (val.water > 100) {
                    $.post(`https://${this.resourceName}/hudselected`, JSON.stringify({
                        settingstype: "hideBoxData", val: {
                            ...this.hideBoxData,
                            ["water"]: 100
                        }
                    }));
                }
                if (val.armor > 100) {
                    $.post(`https://${this.resourceName}/hudselected`, JSON.stringify({
                        settingstype: "hideBoxData", val: {
                            ...this.hideBoxData,
                            ["armor"]: 100
                        }
                    }));
                }
                if (val.hunger > 100) {
                    $.post(`https://${this.resourceName}/hudselected`, JSON.stringify({
                        settingstype: "hideBoxData", val: {
                            ...this.hideBoxData,
                            ["hunger"]: 100
                        }
                    }));
                }
            },
            deep: true
        }
    },
    methods: {
        ResetHudPositions(){
            $.post(`https://${this.resourceName}/ResetHudPositions`, JSON.stringify({  }));

        },
        set_EnableSpeedometer(toggle){
            this.enableSpeedometer = toggle
        },
        set_EnableHUD(toggle) {
            this.enableHud = toggle
        },
        SetEditMode(toggle){
            this.editModeActive = toggle
            if(toggle){
                this.ExitSettings()
                $.post(`https://${this.resourceName}/editModeActive`, JSON.stringify({ toggle : true }));
                SetProgressBar(0)
            }else{
                $.post(`https://${this.resourceName}/editModeActive`, JSON.stringify({ toggle: false }));

            }
        },
        SetHideData(type, e){
            let val = e.target.value
            if(val > 0 && val <= 100){
                $.post(`https://${this.resourceName}/hudselected`, JSON.stringify({
                    settingstype: "hideBoxData", val: {
                        ...this.hideBoxData,
                        [type]: val
                    }
                }));
            }
        },
        GetPositionsData(type) {
            if (this.positionsData[type]) {
                this.position[type].position = "absolute"
                return this.positionsData[type]
            }
        },
        SetHideShowBox(toggle) {
            $.post(`https://${this.resourceName}/hudselected`, JSON.stringify({ settingstype: 'showHideBox', val: toggle }));
        },
        SetEnableHealth(toggle) {
            this.enableHealth = toggle
        },
        SetEnableHunger(toggle) {
            this.enableHunger = toggle
        },
        SetEnableThirst(toggle) {
            this.enableThirst = toggle
        },
        SetEnableStamina(toggle) {
            this.enableStamina = toggle
        },
        SetEnableArmor(toggle) {
            this.enableArmor = toggle
        },
        SetRefreshRate(e) {
            $.post(`https://${this.resourceName}/hudselected`, JSON.stringify({ settingstype: 'refreshRate', val: e.target.value }));

        },
        SetEnableAmmoHUD(val) {
            this.enableAmmoHud = val
        },
        DisplayWeaponAmmo(toggle) {
            this.displayAmmoHud = toggle
        },

        SetAmmos(ammo, max_ammo) {
            this.ammo = ammo
            this.max_ammo = max_ammo

        },
        SetLogoSize(width, height) {
            this.logoWidth = width
            this.logoHeight = height

        },
        SetSpeedometerSize() {
            $.post(`https://${this.resourceName}/hudselected`, JSON.stringify({ settingstype: 'speedometerSize', val: this.speedometerSize }));
        },
        SetStyles(val, val2) {


            this.text2Style = val2
            this.text1Style = val


        },
        SetSelectedMap(map) {
            $.post(`https://${this.resourceName}/hudselected`, JSON.stringify({ settingstype: 'maptype', val: map }));

        },
        SetShowCompass(val) {
            $.post(`https://${this.resourceName}/hudselected`, JSON.stringify({ settingstype: 'showCompass', val }));

        },
        SetUseWaterMarkText(val) {
            this.UseWaterMarkText = val
        },
        SetWaterMarkLogo(val) {
            this.WaterMarkLogo = val
        },
        GetResponse(resourceName) {
            this.resourceName = resourceName
            $.post(`https://${this.resourceName}/SendResponse`, JSON.stringify({}));

        },
        SetCruiseDisplay(val) {
            this.cruiseDisplayActive = val
        },
        SetSeatbeltDisplay(val) {
            this.seatbeltDisplayActive = val
        },
        SetDateDisplay(val) {
            this.dateDisplay = val
        },
        SetWaterMarkHud(val) {
            this.enableWaterMarkHud = val
        },
        SetUseNitro(val) {
            this.useNitro = val
        },
        UpdateAltitude(val) {
            this.showAltitude = val
        },
        UpdateParachute(val) {
            this.showParachute = val
        },
        UpdateJob(joblabel, gradelabel) {
            this.joblabel = joblabel
            this.grade_label = gradelabel
        },
        SetLocales(val) {
            this.locales = val
        },
        UpdateLights(val) {
            this.lightsOn = val
        },
        UpdateSeatbelt(val) {
            this.sealtBeltIsOn = val
        },
        ToggleCruise(val) {
            this.cruiseIsOn = val
        },
        ToggleEngine(val) {
            this.engineIsOn = val
        },
        UseStress(useStress) {
            this.useStress = useStress
        },
        SetDisplayRealTime(val) {
            this.DisplayRealTime = val
        },
        SetDate(clock, date) {
            this.clock = clock
            this.date = date

        },
        SetId(val) {
            this.playerId = val
        },
        SetBankMoney(val) {
            this.bankMoney = val
        },
        SetCash(val) {
            this.cash = val
        },
        UpdateSettings(data) {
            if (data.showHideBox != null && data.showHideBox != undefined) {
                this.showHideBox = data.showHideBox
            }
            if (data.speedtype) {
                this.selectSpeedUnit = data.speedtype
            }
            if (data.maptype) {
                this.selectedMap = data.maptype
            }
            if (data.showCompass != null && data.showCompass != undefined) {
                this.showCompass = data.showCompass
            }
            if (data.hud) {
                this.currentHud = data.hud
            }
            if (data.forceHide != null && data.forceHide != undefined) {
                this.forceHide = data.forceHide
            }
            if (data.refreshRate != null && data.refreshRate != undefined) {
                this.refreshRate = data.refreshRate
                this.displayRefreshRate = data.refreshRate
                if (document.querySelector('#path-2')) {
                    let duration2 = parseInt(this.refreshRate)
                   
                    bar = new ProgressBar.Path('#path-2', {
                        easing: 'easeInOut',

                        duration: duration2
                    });
                    bar.set(1);
                }
            
            }

            if (data.positionsData != null && data.positionsData != undefined) {
                this.positionsData = data.positionsData
            }

            if (data.hideBoxData   != null && data.hideBoxData != undefined) {
                this.hideBoxData = data.hideBoxData
                this.hideBoxDataDisplay = data.hideBoxData

            }
            if (data.hide != null && data.hide != undefined) {
                this.hide = data.hide
            }

            if (data.speedometerSize != null && data.speedometerSize != undefined) {
                this.speedometerSize = data.speedometerSize
            }
        },
        InitDrag() {

            
            $('.textHudMicrophone').draggable({
                helper: "clone",
                revertDuration: 0,
                revert: "invalid",
                cancel: ".item-nodrag",
                containment: "body",
                scroll: false,
                start: function (event, ui) {


                },
                drag: function (event, ui) {

                },
                stop: (event, ui) => {
                    //$(event.target).css('position', "absolute")                    
                    //$(event.target).css('left', ui.position.left)
                    //$(event.target).css('top', ui.position.top)
                    let left = ui.position.left
                    let top = ui.position.top
                    let type = $(event.target).attr('data-type')
                    $.post(`https://${this.resourceName}/hudselected`, JSON.stringify({
                        settingstype: "positionsData", val: {
                            ...this.positionsData,
                            [type]: {
                                position: 'absolute',
                                left: left + 'px',
                                top: top + 'px',
                            }
                        }
                    }));
                    SetProgressBar(0)

                },
            });

            
            $('.classicHudDrag').draggable({
                helper: "clone",
                revertDuration: 0,
                revert: "invalid",
                cancel: ".item-nodrag",
                containment: "body",
                scroll: false,
                start: function (event, ui) {


                },
                drag: function (event, ui) {

                },
                stop: (event, ui) => {
                    //$(event.target).css('position', "absolute")                    
                    //$(event.target).css('left', ui.position.left)
                    //$(event.target).css('top', ui.position.top)
                    let left = ui.position.left
                    let top = ui.position.top
                    let type = $(event.target).attr('data-type')
                    $.post(`https://${this.resourceName}/hudselected`, JSON.stringify({
                        settingstype: "positionsData", val: {
                            ...this.positionsData,
                            [type]: {
                                position: 'absolute',
                                left: left + 'px',
                                top: top + 'px',
                            }
                        }
                    }));
                    SetProgressBar(0)
                },
            });
            $('.textHudIcons').draggable({
                helper: "clone",
                revertDuration: 0,
                revert: "invalid",
                cancel: ".item-nodrag",
                containment: "body",
                scroll: false,
                start: function (event, ui) {


                },
                drag: function (event, ui) {

                },
                stop:  (event, ui) => {
                    //$(event.target).css('position', "absolute")                    
                    //$(event.target).css('left', ui.position.left)
                    //$(event.target).css('top', ui.position.top)
                    let left = ui.position.left
                    let top = ui.position.top
                    let type = $(event.target).attr('data-type')
                    $.post(`https://${this.resourceName}/hudselected`, JSON.stringify({
                        settingstype: "positionsData", val: {
                            ...this.positionsData,
                            [type]: {
                                position : 'absolute',
                                left:left+'px',
                                top:top+'px',
                            }
                        }
                    }));
                    SetProgressBar(0)

                },
            });
        },
        SetForceHide(val) {
            this.forceHide = val
        },
        SetSpeedometerVisibility(visibility, displayOnWalk) {
            this.showSpeedometer = visibility
            this.displayOnWalk = displayOnWalk
        },
        SetHudSettingsVisibilty(visibility) {
            this.settingsOpen = visibility
            if (visibility) {
                this.bar_1 = null
                this.bar_2 = null
                this.bar_3 = null
                this.bar_4 = null
                this.bar_5 = null
                this.bar_6 = null
                this.bar_7 = null
                this.bar_8 = null
                this.bar_9 = null

                this.bar_1_set = false
                this.bar_2_set = false
                this.bar_3_set = false
                this.bar_4_set = false
                this.bar_5_set = false
                this.bar_6_set = false
                this.bar_7_set = false
                this.bar_8_set = false
                this.bar_9_set = false


            }
        },
        SetStatusData(type, val) {
            if (type == "altitude") {
                if (val >= 2483) {
                    val = 2483
                } else if (val <= 0) {
                    val = 0
                }

            }
            if (type == 'health') {
                if (val < 0) {
                    val = 0
                }
            }
            if (typeof (val) == 'boolean') {
                this.statusData[type] = val

            } else {

                this.statusData[type] = val.toFixed(0)
            }

            if (type == "nitro") {
                if (val <= 0) {
                    val = 0
                }
                if (document.querySelector('#nitroLoader')) {
                    init('nitroLoader', 'nitroBorder', val / 100);
                    if (this.bar_8 == null) {
                        this.bar_8 = new ProgressBar.Path('#nitroText', {
                            easing: 'easeInOut',
                            duration: 400
                        });
                    }

                    if (this.bar_8 && !this.bar_8_set) {
                        this.bar_8.set(0)
                        this.bar_8_set = true
                    }
                    this.bar_8.animate(val / 100)

                }

            }
            if (type == "altitude") {
                if (document.querySelector('#altitudeLoader')) {


                    init('altitudeLoader', 'altitudeBorder', 1.0 - (val / 2483));
                    if (this.bar_7 == null) {
                        this.bar_7 = new ProgressBar.Path('#altitudeText', {
                            easing: 'easeInOut',
                            duration: 400
                        });
                    }

                    if (this.bar_7 && !this.bar_7_set) {
                        this.bar_7.set(0)
                        this.bar_7_set = true
                    }
                    this.bar_7.animate(1.0 - (val / 2483))
                }
                if (document.querySelector('#parachuteLoader')) {

                    init('parachuteLoader', 'parachuteBorder', 1.0 - (val / 2483));
                    if (this.bar_9 == null) {
                        this.bar_9 = new ProgressBar.Path('#parachuteText', {
                            easing: 'easeInOut',
                            duration: 400
                        });
                    }

                    if (this.bar_9 && !this.bar_9_set) {
                        this.bar_9.set(0)
                        this.bar_9_set = true
                    }
                    this.bar_9.animate(1.0 - (val / 2483))
                }
            }
            if (type == "health") {
                if (document.querySelector('#healthLoader')) {
                    if (val <= 0) {
                        val = 0
                    }
                    init('healthLoader', 'healthBorder', val / 100);
                    if (this.bar_1 == null) {
                        this.bar_1 = new ProgressBar.Path('#healthText', {
                            easing: 'easeInOut',
                            duration: 400
                        });
                    }

                    if (this.bar_1 && !this.bar_1_set) {
                        this.bar_1.set(0)
                        this.bar_1_set = true
                    }
                    this.bar_1.animate(val / 100)
                }
            }
            if (type == "hunger") {

                if (document.querySelector('#hungerLoader')) {
                    init('hungerLoader', 'hungerBorder', val / 100);
                    if (this.bar_2 == null) {
                        this.bar_2 = new ProgressBar.Path('#hungerText', {
                            easing: 'easeInOut',
                            duration: 400
                        });
                    }

                    if (this.bar_2 && !this.bar_2_set) {
                        this.bar_2.set(0)
                        this.bar_2_set = true
                    }
                    this.bar_2.animate(val / 100)
                }
            }
            if (type == "thirst") {
                if (document.querySelector('#waterLoader')) {
                    init('waterLoader', 'waterBorder', val / 100);
                    if (this.bar_3 == null) {
                        this.bar_3 = new ProgressBar.Path('#waterText', {
                            easing: 'easeInOut',
                            duration: 400
                        });
                    }

                    if (this.bar_3 && !this.bar_3_set) {
                        this.bar_3.set(0)
                        this.bar_3_set = true
                    }
                    this.bar_3.animate(val / 100)
                }
            }
            if (type == "stamina") {

                if (document.querySelector('#staminaLoader')) {
                    init('staminaLoader', 'staminaBorder', val / 100);
                    if (this.bar_4 == null) {
                        this.bar_4 = new ProgressBar.Path('#staminaText', {
                            easing: 'easeInOut',
                            duration: 400
                        });
                    }

                    if (this.bar_4 && !this.bar_4_set) {
                        this.bar_4.set(0)
                        this.bar_4_set = true
                    }
                    this.bar_4.animate(val / 100)
                }
            }
            if (type == "armour") {
                if (document.querySelector('#armorLoader')) {
                    init('armorLoader', 'armorBorder', val / 100);
                    if (this.bar_5 == null) {
                        this.bar_5 = new ProgressBar.Path('#armorText', {
                            easing: 'easeInOut',
                            duration: 400
                        });
                    }

                    if (this.bar_5 && !this.bar_5_set) {
                        this.bar_5.set(0)
                        this.bar_5_set = true
                    }
                    this.bar_5.animate(val / 100)
                }
            }
            if (type == "stress" && this.useStress) {
                if (document.querySelector('#stressLoader')) {
                    init('stressLoader', 'stressBorder', val / 100);
                    if (this.bar_6 == null) {
                        this.bar_6 = new ProgressBar.Path('#stressText', {
                            easing: 'easeInOut',
                            duration: 400
                        });
                    }

                    if (this.bar_6 && !this.bar_6_set) {
                        this.bar_6.set(0)
                        this.bar_6_set = true
                    }
                    this.bar_6.animate(val / 100)
                }
            }

        },
        LocationUpdate(zone, street, heading) {
            street = street.length > 12 ? street.slice(0, 12) + '..' : street
            this.street = street
            zone = zone.length > 12 ? zone.slice(0, 12) + '..' : zone

            this.zone = zone
            this.heading = heading
        },
        OnAddedMoney(amount, minus, moneyType) {
            this.addedMoney = amount
            this.moneyType = moneyType
            this.isMinus = minus
            setTimeout(() => {
                this.addedMoney = null
            }, 1500)
        },
        numberWithSpaces(x) {
            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ");
        },
        SetCurrentHud(hud) {
            $.post(`https://${this.resourceName}/hudselected`, JSON.stringify({ settingstype: 'hud', val: hud }));
        },

        SetSelectSpeedUnit(val) {
            $.post(`https://${this.resourceName}/hudselected`, JSON.stringify({ settingstype: 'speedtype', val }));

        },
        ToggleHud() {
            $.post(`https://${this.resourceName}/hudselected`, JSON.stringify({ settingstype: 'hide', val: !this.hide }));
        },
        ToggleCinematic() {
            $.post(`https://${this.resourceName}/toggleCinematic`, JSON.stringify({}), (val) => {
                this.enableCinematic = val
            });
        },
        ExitSettings() {
            this.SetHudSettingsVisibilty(false)
   
            $.post(`https://${this.resourceName}/ExitSettings`, JSON.stringify({}));
        },
        SetFuel(fuel) {
            this.fuel = fuel
        },
        GetSvg(type) {
            let data = this.svg.filter((s) => s.type == type)
            return data[0] ? data[0].svg : ''
        },
        SetIndicatorDegree(val, rpm) {
            this.speed = val
            this.rpm = rpm
            if (val >= 100) {
                if (val >= 240) {
                    this.indicatorDegree = 240 - 140
                } else {
                    this.indicatorDegree = val - 140
                }
            } else {
                this.indicatorDegree = val - 124

            }
        },
        AddSvg(type, svg) {

            this.svg.push({
                svg,
                type
            })
        },
        SetWaterMarkText(text1, text2) {
            this.text1 = text1
            this.text2 = text2

        }
    },
    computed: {
        GetSpeedometerSize() {
            return {
                transform: `scale(${this.speedometerSize})`
            }
        },
        GetMphButton() {
            return this.selectSpeedUnit == 'mph' ? '<div  class="speedometerButtonActive">MPH</div>' : '<div @click=`SetSelectSpeedUnit(`mph`)` class="speedometerButton">MPH</div>'
        },
        GetKmhButton() {
            return this.selectSpeedUnit == 'kmh' ? '<div class="speedometerButtonActive">KMH</div>' : '<div class="speedometerButton">KMH</div>'

        },

        GetCircleButton() {
            return this.selectedMap == 'radial' ? `<div  class="circleButtonActive">${this.locales['radial']}</div>` : `<div class="circleButtonDisabled">${this.locales['radial']}</div>`
        },
        GetRectangleButton() {
            return this.selectedMap == 'rectangle' ? `<div class="rectangleButtonActive">${this.locales['rectangle']}</div>` : `<div  class="rectangleButtonDisabled">${this.locales['rectangle']}</div>`

        },

        GetSpeed() {
            if (this.speed.length >= 3) {
                return `<span class="activeSpeed">${this.speed}</span>`
            } else if (this.speed.length == 2) {
                return `<span class="lightSpeed">0</span><span class="activeSpeed">${this.speed}</span>`
            } else if (this.speed.length == 1 && this.speed != 0) {
                return `<span class="lightSpeed">00</span><span class="activeSpeed">${this.speed}</span>`
            } else {
                return `<span class="lightSpeed">000</span>`

            }
        },
        style() {
            return { transform: 'translate(-50%, -95%) rotate(' + this.indicatorDegree + 'deg)' }
        }
    },
    mounted() {

        $.post(`https://${this.resourceName}/NuiReady`, JSON.stringify({}));
        this.InitDrag()

    }
})


if (app.DisplayRealTime) {
    let interval = setInterval(() => {
        const date = new Date();
        var dateD = date.getFullYear() + '.' + (date.getMonth() + 1) + '.' + date.getDate();
        let minutes = date.getMinutes()
        let seconds = date.getSeconds()
        if (minutes < 10) {
            minutes = "0" + minutes
        }
        if (seconds < 10) {
            seconds = "0" + seconds
        }
        if (!app.DisplayRealTime) {
            clearInterval(interval)
        }

        const time = date.getHours() + ":" + minutes + ":" + seconds;

        app.SetDate(time, dateD)

    }, 1000)
    const date = new Date();
    var dateD = date.getFullYear() + '.' + (date.getMonth() + 1) + '.' + date.getDate();

    let minutes = date.getMinutes()
    let seconds = date.getSeconds()
    if (minutes < 10) {
        minutes = "0" + minutes
    }
    if (seconds < 10) {
        seconds = "0" + seconds
    }
    const time = date.getHours() + ":" + minutes + ":" + seconds;

    app.SetDate(time, dateD)
}

var fuel


if (document.querySelector('#fuel')) {
    fuel = new ProgressBar.Path('#fuel', {
        easing: 'easeInOut',
        duration: 150
    });
    fuel.set(1);
}


function SetProgressBar(val){
    if (bar) {
        if (val>= 240) {
            bar.animate(240 / 550)

        } else {
            if (val >= 100) {
                bar.animate(val / 550)
            } else {
                bar.animate(val/ 500)
            }
        }

    } else {
        if (document.querySelector('#path-2')) {
           
            bar = new ProgressBar.Path('#path-2', {
                easing: 'easeInOut',

                duration: app.refreshRate
            });
            bar.set(1);
        }
    }
}

window.addEventListener("message", function (event) {
    var item = event.data;
    switch (item.type) {

        case "speed_update":
            let rpm = item.rpm;
            if (bar) {
                if (item.speed >= 240) {
                    bar.animate(240 / 550)

                } else {
                    if (item.speed >= 100) {
                        bar.animate(item.speed / 550)
                    } else {
                        bar.animate(item.speed / 500)
                    }
                }

            } else {
                if (document.querySelector('#path-2')) {
                    
                    bar = new ProgressBar.Path('#path-2', {
                        easing: 'easeInOut',

                        duration: app.refreshRate
                    });
                    bar.set(1);
                }
            }

            app.SetIndicatorDegree(item.speed, rpm)
            break
        case "fuel_update":
            if (fuel) {
                fuel.animate(item.fuel / 100)

            } else {
                if (document.querySelector('#fuel')) {
                    fuel = new ProgressBar.Path('#fuel', {
                        easing: 'easeInOut',
                        duration: 150
                    });
                    fuel.set(1);
                }
            }
            app.SetFuel(item.fuel.toFixed(0))
            break
        case "open_hudsettings":
            app.SetHudSettingsVisibilty(true)
            break
        case "show_speedometer":

            app.SetSpeedometerVisibility(true, item.displayOnWalk)

            break
        case "hide_speedometer":

            app.SetSpeedometerVisibility(false, item.displayOnWalk)
            break
        case "set_status":

            app.SetStatusData(item.statustype, item.value)
            break
        case "update_settings":
            app.UpdateSettings(item.val)
            break
        case "set_id":
            app.SetId(item.value)
            break
        case "set_EnableAmmohud":

            app.SetEnableAmmoHUD(item.value)
            break
        case "update_bank":
            app.SetBankMoney(item.money)
            break
        case "update_money":
            app.SetCash(item.money)
            break
        case "watermark_text":
            app.SetWaterMarkText(item.text1, item.text2)
            break
        case "on_added_money":
            app.OnAddedMoney(item.amount, item.minus, item.moneyType)
            break
        case "location_update":
            app.LocationUpdate(item.street, item.zone, item.heading)
            break
        case "UseStress":
            app.UseStress(item.value)
            break
        case "DisplayRealTime":

            app.SetDisplayRealTime(item.value)
            break
        case "clock_update":
            const date = new Date();
            var dateD = date.getFullYear() + '.' + (date.getMonth() + 1) + '.' + date.getDate();
            app.SetDate(item.hours + ":" + item.minutes, dateD)
            break
        case "toggle_cruise":
            app.ToggleCruise(item.toggle)
            break
        case "toggle_engine":
            app.ToggleEngine(item.toggle)
            break
        case "update_seatbelt":
            app.UpdateSeatbelt(item.toggle)
            break
        case "unbuckle":
            const unbuckle = document.querySelector('#unbuckle')
            unbuckle.volume = event.data.volume;
            unbuckle.play();
            break;
        case "buckle":
            const buckle = document.querySelector('#buckle')
            buckle.volume = event.data.volume;
            buckle.play();
            break;
        case "update_ligths":
            app.UpdateLights(item.state)
            break
        case "set_locales":
            app.SetLocales(item.value)
            break
        case "set_force_hide":
            app.SetForceHide(item.value)
            break
        case "update_job":
            app.UpdateJob(item.joblabel, item.grade_label)
            break
        case "update_parachute":
            app.UpdateParachute(item.val)
            break
        case "update_altitude":
            app.UpdateAltitude(item.val)
            break
        case "set_watermarkhud":
            app.SetWaterMarkHud(item.value)
            break
        case "set_useNitro":
            app.SetUseNitro(item.value)
            break
        case "set_DateDisplay":
            app.SetDateDisplay(item.value)
            break
        case "set_cruiseDisplay":
            app.SetCruiseDisplay(item.value)
            break
        case "set_seatbeltDisplay":
            app.SetSeatbeltDisplay(item.value)
            break
        case "send_response":
            app.GetResponse(item.resourceName)
            break
        case "UseWaterMarkText":
            app.SetUseWaterMarkText(item.value)
            break
        case "WaterMarkLogo":
            app.SetWaterMarkLogo(item.value)
            break
        case "SetStyles":
            app.SetStyles(item.text1, item.text2)
            break
        case "SetLogoSize":
            app.SetLogoSize(item.width, item.height)
            break
        case "display_weapon_ammo":
            app.DisplayWeaponAmmo(item.toggle)
            break
        case "update_weapon_ammo":
            app.SetAmmos(item.ammo, item.maxammo)
            break
        case "set_EnableArmor":
            app.SetEnableArmor(item.value)
            break
        case "set_EnableHealth":
            app.SetEnableHealth(item.value)
            break
        case "set_EnableStamina":
            app.SetEnableStamina(item.value)
            break
        case "set_EnableHunger":
            app.SetEnableHunger(item.value)
            break
        case "set_EnableThirst":
            app.SetEnableThirst(item.value)
            break
        case "set_EnableSpeedometer":
            app.set_EnableSpeedometer(item.value)
            break
        case "set_EnableHUD":
            app.set_EnableHUD(item.value)
            break                        
        default:
            break

    }
})

const handleEsc = (event) => {
    if (event.keyCode === 27) {
        app.ExitSettings()
        app.SetEditMode(false)
    }
};
window.addEventListener('keydown', handleEsc);

