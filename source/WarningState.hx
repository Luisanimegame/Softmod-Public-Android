package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;
import openfl.Assets;

using StringTools;

class WarningState extends MusicBeatState
{   

    
	var dropText:FlxText;
	var warningMusic:FlxSound;

    override function create():Void
	{
	
        var pic:FlxSprite = new FlxSprite(-150, -50).loadGraphic(Paths.image('Not_Safe_Warning'));
		pic.setGraphicSize(Std.int(pic.width * .9));
        pic.alpha = 0;
		add(pic);

        dropText = new FlxText(-150, 0, Std.int(FlxG.width * 1.2), "", 22);
		dropText.font = 'DK Inky Fingers';
		dropText.color = FlxColor.WHITE;
        dropText.alignment = FlxTextAlign.CENTER;
        dropText.alpha = 0;
		add(dropText);
        FlxTween.tween(pic, {alpha: 1}, 1.2, {ease: FlxEase.circOut});
        FlxTween.tween(dropText, {alpha: 1}, 1.2, {ease: FlxEase.circOut});
        
        #if android
        addVirtualPad(NONE, A_B);
        #end
    }


    override function update(elapsed:Float)
	{
		if (warningMusic.volume < 0.3)
			warningMusic.volume += 0.01 * elapsed;
			
        dropText.text = "Aviso!
Este mod trata de tópicos que alguns podem achar desencadeantes.
É possível jogar o mod com segurança pressionando SHIFT para pular o diálogo.
Os gatilhos podem incluir:
Abuso doméstico implícito,
Sinais físicos de violência doméstica,
TEPT,
Menções à Pico's School,
Se você é vítima de violência doméstica, lembre-se de que não está sozinho.
Aproveite a história.
(Pressione qualquer tecla para continuar)";
        dropText.visible = true;
        dropText.screenCenter();
		 if (controls.BACK)
        {
            FlxG.sound.music.stop();
            FlxG.switchState(new MainMenuState());
        }
       
    }
}