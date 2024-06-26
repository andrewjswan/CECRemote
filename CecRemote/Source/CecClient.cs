﻿// This file is part of CECRemote.
//
// CECRemote is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 2 of the License, or
// (at your option) any later version.
//
// CECRemote is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with CECRemote. If not, see <http://www.gnu.org/licenses/>.

using CecRemote.Base;

using MediaPortal.GUI.Library;
using MediaPortal.InputDevices;

namespace CecRemote
{
  public class CecRemoteClient : CecClientBase
  {    
    private InputHandler _remoteHandler;
    
    public CecRemoteClient()
    {
      _remoteHandler = new InputHandler("CecRemote");

      if (!_remoteHandler.IsLoaded)
      {
        Log.Error("CECRemote: Error loading mapping file - check configuration.");
      }

    }

    public override void OnStart()
    {
        base.OnStart();

        GUIPropertyManager.SetProperty("#CecRemote.TV.Vendor", GetVendor(CecSharp.CecLogicalAddress.Tv));
        GUIPropertyManager.SetProperty("#CecRemote.AVR.Vendor", GetVendor(CecSharp.CecLogicalAddress.AudioSystem));
    }

    public override void DeInit()
    {
      base.DeInit();
      _remoteHandler = null;
    }

    protected override void KeyPress(int keycode)
    {
        if (GUIGraphicsContext.form.InvokeRequired)
        {
            InvokeButtonDelegate d = new InvokeButtonDelegate(InvokeButton);
            GUIGraphicsContext.form.Invoke(d, new object[] { keycode });
        }
        else
        {
            InvokeButton(keycode);
        }

    }

    protected override void WriteLog(string message)
    {
        Log.Debug("CECRemote: " + message);
    }

    protected delegate void InvokeButtonDelegate(int button);

    protected void InvokeButton(int button)
    {
        if (!_remoteHandler.MapAction((int)button))
        {
            Log.Info("CECRemote: Received unmapped button with code: " + button.ToString());
        }
    }

  }

}