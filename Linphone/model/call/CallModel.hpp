/*
 * Copyright (c) 2010-2024 Belledonne Communications SARL.
 *
 * This file is part of linphone-desktop
 * (see https://www.linphone.org).
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef CALL_MODEL_H_
#define CALL_MODEL_H_

#include "model/listener/Listener.hpp"
#include "tool/AbstractObject.hpp"

#include <QObject>
#include <linphone++/linphone.hh>

class CallModel : public ::Listener<linphone::Call, linphone::CallListener>,
                  public linphone::CallListener,
                  public AbstractObject {
	Q_OBJECT
public:
	CallModel(const std::shared_ptr<linphone::Call> &account, QObject *parent = nullptr);
	~CallModel();

	void accept(bool withVideo);
	void decline();
	void terminate();

private:
	DECLARE_ABSTRACT_OBJECT

	//--------------------------------------------------------------------------------
	// LINPHONE
	//--------------------------------------------------------------------------------
	virtual void onDtmfReceived(const std::shared_ptr<linphone::Call> &call, int dtmf) override;
	virtual void onGoclearAckSent(const std::shared_ptr<linphone::Call> &call) override;
	virtual void onEncryptionChanged(const std::shared_ptr<linphone::Call> &call,
	                                 bool on,
	                                 const std::string &authenticationToken) override;
	virtual void onSendMasterKeyChanged(const std::shared_ptr<linphone::Call> &call,
	                                    const std::string &sendMasterKey) override;
	virtual void onReceiveMasterKeyChanged(const std::shared_ptr<linphone::Call> &call,
	                                       const std::string &receiveMasterKey) override;
	virtual void onInfoMessageReceived(const std::shared_ptr<linphone::Call> &call,
	                                   const std::shared_ptr<const linphone::InfoMessage> &message) override;
	virtual void onStateChanged(const std::shared_ptr<linphone::Call> &call,
	                            linphone::Call::State state,
	                            const std::string &message) override;
	virtual void onStatsUpdated(const std::shared_ptr<linphone::Call> &call,
	                            const std::shared_ptr<const linphone::CallStats> &stats) override;
	virtual void onTransferStateChanged(const std::shared_ptr<linphone::Call> &call,
	                                    linphone::Call::State state) override;
	virtual void onAckProcessing(const std::shared_ptr<linphone::Call> &call,
	                             const std::shared_ptr<linphone::Headers> &ack,
	                             bool isReceived) override;
	virtual void onTmmbrReceived(const std::shared_ptr<linphone::Call> &call, int streamIndex, int tmmbr) override;
	virtual void onSnapshotTaken(const std::shared_ptr<linphone::Call> &call, const std::string &filePath) override;
	virtual void onNextVideoFrameDecoded(const std::shared_ptr<linphone::Call> &call) override;
	virtual void onCameraNotWorking(const std::shared_ptr<linphone::Call> &call,
	                                const std::string &cameraName) override;
	virtual void onVideoDisplayErrorOccurred(const std::shared_ptr<linphone::Call> &call, int errorCode) override;
	virtual void onAudioDeviceChanged(const std::shared_ptr<linphone::Call> &call,
	                                  const std::shared_ptr<linphone::AudioDevice> &audioDevice) override;
	virtual void onRemoteRecording(const std::shared_ptr<linphone::Call> &call, bool recording) override;

signals:
	void dtmfReceived(const std::shared_ptr<linphone::Call> &call, int dtmf);
	void goclearAckSent(const std::shared_ptr<linphone::Call> &call);
	void
	encryptionChanged(const std::shared_ptr<linphone::Call> &call, bool on, const std::string &authenticationToken);
	void sendMasterKeyChanged(const std::shared_ptr<linphone::Call> &call, const std::string &sendMasterKey);
	void receiveMasterKeyChanged(const std::shared_ptr<linphone::Call> &call, const std::string &receiveMasterKey);
	void infoMessageReceived(const std::shared_ptr<linphone::Call> &call,
	                         const std::shared_ptr<const linphone::InfoMessage> &message);
	void stateChanged(linphone::Call::State state, const std::string &message);
	void statsUpdated(const std::shared_ptr<linphone::Call> &call,
	                  const std::shared_ptr<const linphone::CallStats> &stats);
	void transferStateChanged(const std::shared_ptr<linphone::Call> &call, linphone::Call::State state);
	void ackProcessing(const std::shared_ptr<linphone::Call> &call,
	                   const std::shared_ptr<linphone::Headers> &ack,
	                   bool isReceived);
	void tmmbrReceived(const std::shared_ptr<linphone::Call> &call, int streamIndex, int tmmbr);
	void snapshotTaken(const std::shared_ptr<linphone::Call> &call, const std::string &filePath);
	void nextVideoFrameDecoded(const std::shared_ptr<linphone::Call> &call);
	void cameraNotWorking(const std::shared_ptr<linphone::Call> &call, const std::string &cameraName);
	void videoDisplayErrorOccurred(const std::shared_ptr<linphone::Call> &call, int errorCode);
	virtual void audioDeviceChanged(const std::shared_ptr<linphone::Call> &call,
	                                const std::shared_ptr<linphone::AudioDevice> &audioDevice);
	void remoteRecording(const std::shared_ptr<linphone::Call> &call, bool recording);
};

#endif