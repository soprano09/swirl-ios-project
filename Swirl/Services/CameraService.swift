//
//  CameraService.swift
//  Swirl
//
//  Created by Bojan Stefanovic on 9/17/17.
//  Copyright © 2017 Stefanovic Ventures. All rights reserved.
//

import NextLevel
import CoreGraphics
import AVFoundation

private struct Constants {
    private static let seconds = GlobalConstants.maximumVideoCaptureTime
    static let maximumCaptureDuration = CMTime(seconds: seconds, preferredTimescale: 600)
    static let audioConfigurationBitRate = 44_000
}

protocol CameraServiceable {
    func start() throws
    func stop()
    func previewLayer(frame: CGRect) -> AVCaptureVideoPreviewLayer
    func record()
    func pause()
    func flipCamera()
}

final class CameraService: NSObject {
    fileprivate let nextLevel: NextLevel

    static var defaultService: CameraServiceable {
        let nextLevel = NextLevel()
        return CameraService(nextLevel: nextLevel)
    }

    private init(nextLevel: NextLevel) {
        self.nextLevel = nextLevel
        super.init()
        setup()
    }
}

extension CameraService: CameraServiceable {
    func start() throws {
        if nextLevel.authorizationStatus(forMediaType: AVMediaType.video) == .authorized &&
            nextLevel.authorizationStatus(forMediaType: AVMediaType.audio) == .authorized {
            try nextLevel.start()
        } else {
            nextLevel.requestAuthorization(forMediaType: AVMediaType.video)
            nextLevel.requestAuthorization(forMediaType: AVMediaType.audio)
        }
    }

    func stop() {
        nextLevel.stop()
    }

    func previewLayer(frame: CGRect) -> AVCaptureVideoPreviewLayer {
        nextLevel.previewLayer.frame = frame
        return nextLevel.previewLayer
    }

    func record() {
        nextLevel.record()
    }

    func pause() {
        nextLevel.pause()
    }

    func flipCamera() {
        nextLevel.flipCaptureDevicePosition()
    }
}

extension CameraService: NextLevelDelegate {
    func nextLevel(_ nextLevel: NextLevel, didUpdateAuthorizationStatus status: NextLevelAuthorizationStatus,
                   forMediaType mediaType: AVMediaType) {

        if nextLevel.authorizationStatus(forMediaType: AVMediaType.video) == .authorized &&
            nextLevel.authorizationStatus(forMediaType: AVMediaType.audio) == .authorized {
            do {
                try nextLevel.start()
            } catch {
                print(#file, #function, error)
            }
        } else if status == .notAuthorized {
            print("NextLevel doesn't have authorization for audio or video.")
        }
    }

    func nextLevel(_ nextLevel: NextLevel,
                   didUpdateVideoConfiguration videoConfiguration: NextLevelVideoConfiguration) {}
    func nextLevel(_ nextLevel: NextLevel,
                   didUpdateAudioConfiguration audioConfiguration: NextLevelAudioConfiguration) {}
    func nextLevelSessionWillStart(_ nextLevel: NextLevel) {}
    func nextLevelSessionDidStart(_ nextLevel: NextLevel) {}
    func nextLevelSessionDidStop(_ nextLevel: NextLevel) {}
    func nextLevelSessionWasInterrupted(_ nextLevel: NextLevel) {}
    func nextLevelSessionInterruptionEnded(_ nextLevel: NextLevel) {}
    func nextLevelWillStartPreview(_ nextLevel: NextLevel) {}
    func nextLevelDidStopPreview(_ nextLevel: NextLevel) {}
    func nextLevelCaptureModeWillChange(_ nextLevel: NextLevel) {}
    func nextLevelCaptureModeDidChange(_ nextLevel: NextLevel) {}
}

extension CameraService: NextLevelVideoDelegate {
    func nextLevel(_ nextLevel: NextLevel, didUpdateVideoZoomFactor videoZoomFactor: Float) {}
    func nextLevel(_ nextLevel: NextLevel, willProcessRawVideoSampleBuffer sampleBuffer: CMSampleBuffer,
                   onQueue queue: DispatchQueue) {}
    func nextLevel(_ nextLevel: NextLevel, renderToCustomContextWithImageBuffer imageBuffer: CVPixelBuffer,
                   onQueue queue: DispatchQueue) {}
    func nextLevel(_ nextLevel: NextLevel, didSetupVideoInSession session: NextLevelSession) {}
    func nextLevel(_ nextLevel: NextLevel, didSetupAudioInSession session: NextLevelSession) {}
    func nextLevel(_ nextLevel: NextLevel, didStartClipInSession session: NextLevelSession) {}
    func nextLevel(_ nextLevel: NextLevel, didCompleteClip clip: NextLevelClip, inSession session: NextLevelSession) {}
    func nextLevel(_ nextLevel: NextLevel, didAppendVideoSampleBuffer sampleBuffer: CMSampleBuffer,
                   inSession session: NextLevelSession) {}
    func nextLevel(_ nextLevel: NextLevel, didAppendAudioSampleBuffer sampleBuffer: CMSampleBuffer,
                   inSession session: NextLevelSession) {}
    func nextLevel(_ nextLevel: NextLevel, didSkipVideoSampleBuffer sampleBuffer: CMSampleBuffer,
                   inSession session: NextLevelSession) {}
    func nextLevel(_ nextLevel: NextLevel, didSkipAudioSampleBuffer sampleBuffer: CMSampleBuffer,
                   inSession session: NextLevelSession) {}
    func nextLevel(_ nextLevel: NextLevel, didCompleteSession session: NextLevelSession) {}
    func nextLevel(_ nextLevel: NextLevel, didCompletePhotoCaptureFromVideoFrame photoDict: [String : Any]?) {}
}

fileprivate extension CameraService {
    func setup() {
        nextLevel.delegate = self
        nextLevel.videoDelegate = self
        nextLevel.videoConfiguration.maximumCaptureDuration = Constants.maximumCaptureDuration
        nextLevel.audioConfiguration.bitRate = Constants.audioConfigurationBitRate
    }
}
