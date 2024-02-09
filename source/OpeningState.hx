package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class OpeningState extends MusicBeatState
{
	public static var alreadySeenOpenState:Bool = false;

	var youshould:FlxText;
	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		youshould = new FlxText(0, 0, FlxG.width,
			"Hey, heads up!\n
			I recomend you go into settings before anything!\n
			I added some stuff you might wanna look into before anything in there!\n
			Press ENTER to start the game.\n
			Press ESCAPE to go to options.\n
			Have fun!",
			32);
            youshould.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
            youshould.screenCenter(Y);
			youshould.alignment = CENTER;
		add(youshould);
	}

	override function update(elapsed:Float)
	{
		if(!alreadySeenOpenState) {
			var back:Bool = controls.BACK;
			if (controls.ACCEPT || back) {
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if(!back) {
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxFlicker.flicker(youshould, 1, 0.1, false, true, function(flk:FlxFlicker) {
						new FlxTimer().start(0.5, function (tmr:FlxTimer) {
							MusicBeatState.switchState(new TitleState());
						});
					});
                    alreadySeenOpenState = true;
				} else {
                    FlxTransitionableState.skipNextTransIn = false;
                    FlxTransitionableState.skipNextTransOut = false;
					FlxG.sound.play(Paths.sound('cancelMenu'));
					MusicBeatState.switchState(new options.OptionsState());
					options.OptionsState.checkedInOpening = true;
				}
			}
		}
		super.update(elapsed);
	}
}
