package switched;

#if desktop
import Discord.DiscordClient;
import sys.thread.Thread;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import haxe.Json;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import options.GraphicsSettingsSubState;
//import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFrame;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.sound.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.Assets;
import flixel.addons.display.FlxBackdrop;

class MonsterChooseState extends MusicBeatState
{
    var backdrop:FlxBackdrop;
    var redbg:FlxSprite;
    var ecxtabar:FlxSprite;
    var monsterselecti:FlxSprite;

    public static var curSelected:Int = 0;

    var grpCharacters:FlxTypedGroup<FlxSprite>;
    var characters:FlxSprite;
    var characterNames:Array<String> = ['xeno', 'malic'];

    var xenoText:FlxSprite;
    var malicText:FlxSprite;

    var insertedSecretCode:Bool = true;
    var code:Int = 0;

    override public function create():Void
    {
        transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

        persistentUpdate = persistentDraw = true;

        Conductor.changeBPM(120);

        FlxG.sound.playMusic(Paths.music('DoubleFake', 'baited'));

        redbg = new FlxSprite().loadGraphic(Paths.image('bg/redOv', 'baited'));
        redbg.scrollFactor.set(0,0);
        redbg.scale.set(0.68,0.68);
        redbg.screenCenter(X);
        redbg.screenCenter(Y);
        add(redbg);

        backdrop = new FlxBackdrop(Paths.image('bg/back', 'baited'));
		backdrop.scrollFactor.set(0, 0); 
		backdrop.screenCenter(X);
		add(backdrop); 

        ecxtabar = new FlxSprite().loadGraphic(Paths.image('bg/hoosin', 'baited'));
        ecxtabar.scrollFactor.set(0,0);
        ecxtabar.scale.set(0.68,0.68);
        ecxtabar.screenCenter(X);
        ecxtabar.screenCenter(Y);
        add(ecxtabar);

        grpCharacters = new FlxTypedGroup<FlxSprite>();
		add(grpCharacters);

        xenoText = new FlxSprite(-300,-180);
        xenoText.frames = Paths.getSparrowAtlas('characters/XenoUIBUTTON', 'baited');
        xenoText.animation.addByPrefix('deselected', 'deselected', 24, true);
        xenoText.animation.addByPrefix('selected', 'selected', 24, true);
        xenoText.animation.play('idle', true);

        malicText = new FlxSprite(-330,-180);
        malicText.frames = Paths.getSparrowAtlas('characters/MalicUIBUTTON', 'baited');
        malicText.animation.addByPrefix('deselected', 'deselect', 24, true);
        malicText.animation.addByPrefix('selected', 'select', 24, true);
        malicText.animation.play('idle', true);

        malicText.scale.set(0.68,0.68);
        xenoText.scale.set(0.68,0.68);

        malicText.scrollFactor.set(0,0);
        xenoText.scrollFactor.set(0,0);


        for (i in 0...characterNames.length)
        {
            characters = new FlxSprite(0,0);
            characters.scrollFactor.set(0,0);
            characters.scale.set(0.68,0.68);
            characters.ID = i;

            grpCharacters.add(characters);

            switch (i)
            {
                case 0:
                    characters.frames = Paths.getSparrowAtlas('characters/XenoCHOOSENIGHTMARE', 'baited');
                    characters.animation.addByPrefix('idle', 'smug piece of shit', 15, true);
                    characters.animation.addByPrefix('selected', 'selected', 15, true);
                    characters.animation.play('idle', true);
                    characters.setPosition(-310,-180);
                case 1:
                    characters.frames = Paths.getSparrowAtlas('characters/MalicCHOOSENIGHTMARE', 'baited');
                    characters.animation.addByPrefix('idle', 'the rot consumes', 12, true);
                    characters.animation.addByPrefix('selected', 'selected', 15, true);
                    characters.animation.play('idle', true);
                    characters.setPosition(-325,-185);
            }
        }

        add(xenoText);
        add(malicText);

        changeSelection();

        super.create();
    }

    var selectedSomethin = false;
    override public function update(elapsed:Float)
    {
		backdrop.x += .5*(elapsed/(1/120)); 
		backdrop.y -= 0.5 / (ClientPrefs.framerate / 60); 

		if (!selectedSomethin)
        {
            if (controls.BACK)
            {
                selectedSomethin = true;
                FlxG.sound.play(Paths.sound('cancelMenu'));
                MusicBeatState.switchState(new MainMenuState());
                FlxG.sound.playMusic(Paths.music('freakyMenu'));
            }

            if (controls.ACCEPT)
            {
                selectedSomethin = true;
                FlxG.sound.play(Paths.sound('confirmMenu'));
                versionSelected(characterNames[curSelected], 0);

                grpCharacters.forEach(function(spr:FlxSprite)
                {    
                    if (spr.ID == curSelected)
                    {
                        spr.animation.play('selected', true);
                    }
                });
            }

            if (controls.UI_LEFT_P)
                changeSelection(-1);
            else if (controls.UI_RIGHT_P)
                changeSelection(1);
        }

        if (!insertedSecretCode)
        {
            if (FlxG.keys.justPressed.S)
                if (code == 0)
                    code = 1;
                else
                    code == 0;
    
            if (FlxG.keys.justPressed.T)
                if (code == 1)
                    code = 2;
                else
                    code == 0;
    
            if (FlxG.keys.justPressed.O)
                if (code == 2)
                    code = 3;
                else
                    code == 0;
    
            if (FlxG.keys.justPressed.C)
                if (code == 3)
                    code = 4;
                else
                    code == 0;

            if (FlxG.keys.justPressed.K)
                if (code == 4)
                    code = 5;
                else
                    code == 0;
    
            if (code == 5)
            {
                insertedSecretCode = true;
                FlxG.sound.play(Paths.sound('confirmMenu'));
                versionSelected(characterNames[curSelected], 1);
    
                grpCharacters.forEach(function(spr:FlxSprite)
                {    
                    if (spr.ID == curSelected)
                    {
                        spr.animation.play('selected', true);
                    }
                });
            }
        }

        super.update(elapsed);
    }

    function changeSelection(change:Int = 0)
    {
        curSelected += change;

        if (curSelected < 0)
            curSelected = characterNames.length - 1;
        if (curSelected >= characterNames.length)
            curSelected = 0;

        FlxG.sound.play(Paths.sound('scrollMenu'));

        if (curSelected == 0) {
            malicText.animation.play('deselected');
            xenoText.animation.play('selected');  
        } else if (curSelected == 1) {
            xenoText.animation.play('deselected');
            malicText.animation.play('selected');  
        }
    }

    function versionSelected(selectedMonster:String, type:Int = 0)
    {
        switch (type)
        {
            case 0:
                PlayState.SONG = Song.loadFromJson('immortal-enemies-' + selectedMonster, 'immortal-enemies');

                new FlxTimer().start(1, function(tmr:FlxTimer)
                    {
                        LoadingState.loadAndSwitchState(new PlayState());
                    });
                    
                trace(selectedMonster + ' Selected');
            case 1:
                PlayState.SONG = Song.loadFromJson('virgin-rage-immortalmix-' + selectedMonster, 'virgin-rage-immortalmix');

                new FlxTimer().start(1, function(tmr:FlxTimer)
                    {
                        LoadingState.loadAndSwitchState(new PlayState());
                    });
                    
                trace(selectedMonster + ' Selected');
        }
    }
}