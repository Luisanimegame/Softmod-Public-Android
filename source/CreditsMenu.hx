package;

import openfl.display.BitmapData;
import openfl.system.System;
import flixel.util.FlxTimer;
import flixel.math.FlxRandom;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.addons.transition.FlxTransitionableState;

using StringTools;

class CreditsMenu extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;
	var boolList = StoryMenuState.getLocks();
	
	public static var credits:Array<String> = [
	"Preguiça de por os links, sorry",
	'',
	'PORTER:',
	'Gaby Wuzzy',
	'',
	'Para o DGL:',
	'cade meu legalmix? eu necessito dele agora',
	'',
	'de aqui em diante não funciona',
	'procure os donos na internet:D',
	'',
	'DIRECTOR:',
	'Tamacoochi ',
	'',
	'ARTISTS:',
	'Drizz',
	'Starrie Blu',
	'Dio',
	'ElikaPika',
	'Citrus',
	'EvanClubYT',
	'Nat',
	'HexerRush',//11
	'Azure',
	'Kalli.Moya',
	'',
	'MUSICIANS:',
	'Starrie Blu',//16
	'MegaBlade',
	'Kalpy', 
	'Hamm Slamm',
	'StardustTunes', ///20
	'Rozebud',
	'',
	'PROGRAMMERS:',
	'Disky',
	'Starrie Blu',
	'Smokey', 
	'Rozebud', 
	'Flippy',
	'Ash', ///28
	'Clowfoe',
	'',
	'CHARTERS:',
	'Flippy', //31
	'Kalpy', 
	'EthantheDoodler', 
	'Cval',
	'Shea',
	'',
	'SPECIAL THANKS:',
	'Kolsan',
	'Wiki',
	'Buniberi',
	'Crystal',
	'fueg0',
	'Danni',
	'Kartin Crew',
	'Church Soop',
	'My beloved',
	'Eboymode'
	];

	override function create()
	{
		FlxG.sound.cache('assets/data/senpai/confirmSound.ogg');
		//if (!FlxG.sound.music.playing)
		//{
		//	FlxG.sound.playMusic(Paths.inst('whale-waltz'));
		//}
		
		if(!FlxG.sound.music.playing){
			FlxG.sound.playMusic(Paths.music("SoftConfig", "shared"));
		}
		
		FlxG.autoPause = false;
	
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBG'));
		add(bg);

		selector = new FlxText();

		selector.size = 40;
		selector.text = ">";
		// add(selector);

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		for (i in 0...credits.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, new EReg('_', 'g').replace(new EReg('0', 'g').replace(credits[i], 'O'), ' '), true, false);
			songText.isMenuItem = true;
			songText.targetY = i;

			if(credits[i].contains(":")){
				songText.color = 0xFFFFFF00;
			}

			grpSongs.add(songText);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}

		changeSelection();

		// FlxG.sound.playMusic(Paths.music('title'), 0);
		// FlxG.sound.music.fadeIn(2, 0, 0.8);
		selector = new FlxText();

		selector.size = 40;
		selector.text = ">";
		// add(selector);

		var swag:Alphabet = new Alphabet(1, 0, "swag");
		
		#if android
        addVirtualPad(LEFT_FULL, A_B);
        #end

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if (FlxG.keys.justPressed.F)
		{
		FlxG.fullscreen = !FlxG.fullscreen;
		}

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}
		

		if (controls.BACK)
		{
			FlxG.sound.music.stop();
			FlxG.autoPause = true;
			FlxG.switchState(new MainMenuState());
		}

		if (accepted)
		{
			trace(curSelected);
			switch (curSelected){
				case 0:
				case 1:
				case 2:
				case 3:
					fancyOpenURL("https://youtube.com/@gabewuzx?si=5vCAmKI0eOXzKwpB");
				case 4:
				case 5:
				case 6:
					fancyOpenURL("https://youtu.be/DowEPBsCVoY?si=gL0NNpCln7Qc0Ew2");
				
				default:
					trace(curSelected);

			
			
			
			
			}
		}
	}

	function changeSelection(change:Int = 0)
	{

		curSelected += change;

		if (curSelected < 0)
			curSelected = credits.length - 1;
		if (curSelected >= credits.length)
			curSelected = 0;

		var changeTest = curSelected;

		if(credits[curSelected] == "" || credits[curSelected].contains(":") && credits[curSelected] != "PROGRAMMERS:" && credits[curSelected] != "Press Enter For Social:"){
			changeSelection(change == 0 ? 1 : change);
		}

		if(changeTest == curSelected){
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
			trace("ayo doep"); // ?????
		}
		

		var bullShit:Int = 0;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}

	}
}